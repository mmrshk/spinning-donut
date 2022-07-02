class Donut
  include Math

  R1 = 1.0
  R2 = 2.0
  K2 = 5.0
  SS = 50
  K1 = SS * K2 * 3 / (8 * (R1 + R2))

  def rf(a, b)
    cosA = cos(a)
    sinA = sin(a)
    cosB = cos(b)
    sinB = sin(b)
    o = Array.new(SS).fill { Array.new(SS).fill(' ') }
    b = Array.new(SS).fill { Array.new(SS).fill(0) }
    t = 0.0

    while t < 2 * PI
      cost = cos(t)
      sint = sin(t)
      p = 0.0

      while p < 2 * PI
        cosp = cos(p)
        sinp = sin(p)

        cx = R2 + R1 * cost
        cy = R1 * sint
        x = cx * (cosB * cosp + sinA * sinB * sinp) - cy * cosA * sinB
        y = cx * (sinB * cosp - sinA * cosB * sinp) + cy * cosA * cosB
        z = K2 + cosA * cx * sinp + cy * sinA
        ooz = 1 / z
        xp = (SS / 2 + K1 * ooz * x).to_i
        yp = (SS / 2 - K1 * ooz * y).to_i
        l = cosp * cost * sinB - cosA * cost * sinp - sinA * sint + cosB * (cosA * sint - cost * sinA * sinp)

        if l > 0 && (ooz > b[xp][yp])
          b[xp][yp] = ooz
          o[xp][yp]='.,-~:;=!*#$@'[(l*8.0).to_i] || " ";
        end

        p += 0.02
      end

      t += 0.07
    end

    print("\x1b[H")

    SS.times do |j|
      SS.times do |i|
        print(o[i][j])
      end
      print("\n")
    end
  end
end

a = b = 3.0

loop do
  Donut.new.rf(a, b)
  a += 0.07
  b += 0.03
  sleep 0.01
end
