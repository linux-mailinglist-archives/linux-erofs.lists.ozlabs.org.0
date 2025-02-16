Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5DA37801
	for <lists+linux-erofs@lfdr.de>; Sun, 16 Feb 2025 23:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739744155;
	bh=tz4RhJbZlFysoxm+oSYsFEXeHm2mF8AfKqHY8C1v/rs=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=mhDvDgULqp9gLWPmq+Bl2YU2JxLera4pDtTIkH/iOHpqEdYdkBLg9E2CzkqE1mc3s
	 H9/H1G70EYqyFXD5uN2I8zYgMBrssbtMg2fWL0WVeu2nHt2yERRFzuRzn1CvNorUmS
	 YMvDmu3vYG59e2Yd0hvO/Msq373pM2tC7OsAZYqyaSljFgu7b90/u4yIbJDaqSN6Ny
	 /ZvH96xrUOhmXxdAz1sgQZeb3uEe67jKjpyQDQbdqWdhFCkVQNnNLC3fchzaJKcDiu
	 SA9T4JlqiOR0+Zy7aHH11oSyuhJeEEk7KRHsKkUwLfaUBukCtc4LMWg1FrJW4PRo97
	 iICKT4M6M2ruw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yx0VM2XQCz3039
	for <lists+linux-erofs@lfdr.de>; Mon, 17 Feb 2025 09:15:55 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1042"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739744153;
	cv=none; b=o2tV+OMixADu3ENlRI0i8waPovkppe62Lt6XH0oSDgn2FzUYnYC5E26J2J2c7G6YNwktEUvDDGJ8yEuUyP4Jh+sVs8gP/Vg6IwP3LSYAvYOckWYZVhQ3CPJMn4d6siykD6zHNKhRa4yfA5DkRJ5jfqoDeOJNjLGs9b9PDqMrZjrT4vlgMCX4GI1XTBlaIClmGu4MHqmfiDqVlZgxWS7in87pG6y0h24M9M+BCqjP9kKRR/Qy8QOsMyL5coXzhQDY/EC+XOKmPQwi0+LP9d+7h5Qq9Y/KvefqgHDG+zxWJnMCLOZPdokpXsPR3qvy/DsjZ1nR8g/8rxCPx8Zgv7lSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739744153; c=relaxed/relaxed;
	bh=tz4RhJbZlFysoxm+oSYsFEXeHm2mF8AfKqHY8C1v/rs=;
	h=Date:From:To:Subject:Mime-Version:Message-ID:Content-Type; b=TCks0ZX0vyWpWGn0MU+ne7ywAQMpzvh6L9IVCxhA9iAw2rQN/E/u8AalUNjXowlDLGstj2rGlGgAxU6W8Z+9GRpMTKmK5dCoa0SGiE2p0Xz5hq6h3+sITax0A8o9freTnwb9P6AX1HQsikGo7AHwDhJ2OvbuZhT4Zf1yppg+IZ1YVe+972YCFbwRx+CLf9w0BvQcNZyBn7BaqnsgS0TNEbvATVmXrBfC+DR8JATglkUNV2lpOu9mDA/pDJWAp5UVJ0rpIQqIq7qz6PUbcAlB94KyKUdJ6eztzjj56uE39KQ5htFdOiVRk2/4cfSvglj9xTGeNITl72OmlFMvq+8DCw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ys55.net; dkim=pass (1024-bit key; unprotected) header.d=ys55.net header.i=@ys55.net header.a=rsa-sha256 header.s=google header.b=HGDnB084; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=sendonly498@ys55.net; receiver=lists.ozlabs.org) smtp.mailfrom=ys55.net
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=ys55.net
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=ys55.net header.i=@ys55.net header.a=rsa-sha256 header.s=google header.b=HGDnB084;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=ys55.net (client-ip=2607:f8b0:4864:20::1042; helo=mail-pj1-x1042.google.com; envelope-from=sendonly498@ys55.net; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yx0VJ1X5wz2xjK
	for <linux-erofs@lists.ozlabs.org>; Mon, 17 Feb 2025 09:15:51 +1100 (AEDT)
Received: by mail-pj1-x1042.google.com with SMTP id 98e67ed59e1d1-2fa7465baceso7666762a91.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 16 Feb 2025 14:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ys55.net; s=google; t=1739744148; x=1740348948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:message-id:mime-version:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tz4RhJbZlFysoxm+oSYsFEXeHm2mF8AfKqHY8C1v/rs=;
        b=HGDnB084dS1Le7zLyJjX1Sw/Ri9au62M1QAMUXb9csCinx2aG4yFfA+k584P/aHqZO
         dD3STPFnCjQKsKE3onxzhIAj5myw2hP88/1qmXpac9lo4mp5/CCfVbtQi8U13EqdlpFa
         XpkiXwkDMFR1fAGHryS2IQ1NO+SMv3vU5LIlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739744148; x=1740348948;
        h=content-transfer-encoding:message-id:mime-version:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tz4RhJbZlFysoxm+oSYsFEXeHm2mF8AfKqHY8C1v/rs=;
        b=ZlikGnCSoHUgscuswDv8BoWkaW/ppy6nBuWnWUBFGu10qWXA/kGHYUJDf2xxpRqwyt
         QieScFP8MOcgW7dB/d4H0U23zGVqhzE2jkWasboaRqXvxsabNkNI5GXtbEj31MChtbF9
         Bqt1bNFleHz1g1cf0AP0EzIDHO5fuHdF2YWjebK0j6YtF84DxBAbqcFRV8UBQcmJNdrK
         ACpDiBRJgqANvmIrpg74hn+/hctUiWC4mHbdYYt6Vhb8EaH6PFaxWSWR1GxzVgLImGNt
         +TpP5T+Gf65BbMB4RE7sgGjvsOigHgUF6NCcuVPFcmAcdyXAyiIEFyv12RSoIKlBdLkQ
         6unA==
X-Gm-Message-State: AOJu0YwZawRDgVyBa0rophV4gDL2ng7S1d7TPwHriBBcTo1Nc+U1Rpuq
	PPxfaj30tILJTTloxtQPBWdWELfaak3SpmOf3MMWo5PgWxz2xOK2yHpE8TW4CpM57uP0Lzq3FrF
	9R4QlKQ==
X-Gm-Gg: ASbGncvQhRdCcZOyagsTZV/ZP8+2UFOuFrlBD0BitrNPOPqA23UkkAzPHVfRDNllw9n
	d1BCv3eU/QzSEyn8iIhAl7UUct/eQsEb1WAYz/T9dtH2WZujPOxMX1Tmrq6Z+GUYIkGzp6r9Tuo
	POrvmOzrytAdnk2IlEb8RXWhwosiZt/bsq5BIPGuM3LGwofX1js7D4kG0y225VKiu4QGrUJm29h
	fqX5NNlt60oZcuZRLb/UdVFPcHXXsXzNWohPNHQaLG6Hb1g6UYzFBopKACu1NOkH/+mTH8vPhRB
	eWRKmecZEDd59cOy1fzXc+v0/82a+CKR88qu1HSJMvzz
X-Google-Smtp-Source: AGHT+IFFlD/7/3EuHoRn/Z6MASvfJR/yGvP2UVG7Un3graUSE88Sj9CcqIq5YRiOF3Ob13oGZ7xE0w==
X-Received: by 2002:a05:6a00:3096:b0:732:6248:ff73 with SMTP id d2e1a72fcca58-7326248ffd7mr9726647b3a.3.1739744147623;
        Sun, 16 Feb 2025 14:15:47 -0800 (PST)
Received: from ouf (47-158-27-121.lsan.ca.frontiernet.net. [47.158.27.121])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732658987f0sm3248569b3a.10.2025.02.16.14.15.46
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 14:15:47 -0800 (PST)
Date: Sun, 16 Feb 2025 14:15:47 -0800 (PST)
X-Google-Original-Date: Sun, 16 Feb 2025 22:15:36 +000
To: linux-erofs <linux-erofs@lists.ozlabs.org>
Subject: =?SHIFT_JIS?B?juaI+Jbak0mTmYLMim2URoLMgqiK6IKi?=
X-Priority: 3
X-Has-Attach: no
Mime-Version: 1.0
Message-ID: <202502162215471651617@ys55.net>
Content-Type: text/plain;
	charset="SHIFT_JIS"
Content-Transfer-Encoding: Quoted-Printable
X-Spam-Status: No, score=1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=disabled version=4.0.0
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
From: =?utf-8?b?SkHjg43jg4Pjg4jjg5Djg7Pjgq8gdmlhIExpbnV4LWVyb2Zz?= <linux-erofs@lists.ozlabs.org>
Reply-To: =?SHIFT_JIS?B?SkGDbINig2eDb4OTg04=?= <sendonly498@ys55.net>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

=95=BD=91f=82=E6=82=E8=81A=82i=82`=83l=83b=83g=83o=83=93=83N=82=F0=82=B2=
=97=98=97p=82=A2=82=BD=82=BE=82=AB=81A=82=A0=82=E8=82=AA=82=C6=82=A4=82=
=B2=82=B4=82=A2=82=DC=82=B7=81B
=93=96=8Ds=82=CD=81A=82=A8=8Bq=97l=82=C9=88=C0=91S=82=C5=88=C0=90S=82=C8=
=8E=E6=88=F8=8A=C2=8B=AB=82=F0=92=F1=8B=9F=82=B7=82=E9=82=BD=82=DF=81A=
=93=C1=8E=EA=8D=BC=8B\=96h=8E~=81A=83}=83l=81[=81E=83=8D=81[=83=93=83_=
=83=8A=83=93=83O=91=CE=8D=F4=81A=83e=83=8D=8E=91=8B=E0=8B=9F=97^=96h=8E=
~=82=C9=8E=E6=82=E8=91g=82=F1=82=C5=82=A2=82=DC=82=B7=81B

=82=BB=82=CC=88=EA=8A=C2=82=C6=82=B5=82=C4=81A=92=E8=8A=FA=93I=82=C9=81=
u=82=A8=8E=E6=88=F8=96=DA=93I=93=99=82=CC=8Am=94F=81v=82=F0=82=A8=8A=E8=
=82=A2=82=B5=82=C4=82=A8=82=E8=82=DC=82=B7=81B=82=B1=82=EA=82=CD=81A=94=
=C6=8D=DF=8E=FB=89v=88=DA=93]=96h=8E~=96@=82=A8=82=E6=82=D1=8B=E0=97Z=92=
=A1=82=CC=83K=83C=83h=83=89=83C=83=93=82=C9=8A=EE=82=C3=82=AD=82=E0=82=
=CC=82=C5=81A=82=A8=8Bq=97l=82=CC=8F=EE=95=F1=81i=8FZ=8F=8A=81A=90E=8B=
=C6=81A=8E=E6=88=F8=96=DA=93I=93=99=81j=82=F0=8Am=94F=82=B7=82=E9=82=BD=
=82=DF=82=CC=82=E0=82=CC=82=C5=82=B7=81B

=81y=8Am=94F=82=CC=82=A8=8A=E8=82=A2=81z
2025=94N2=8C=8E18=93=FA=82=DC=82=C5=82=C9=81A=89=BA=8BL=82=CC=83=8A=83=
=93=83N=82=E6=82=E8=82=B2=8E=A9=90g=82=CC=8F=EE=95=F1=82=F0=82=B2=8Am=94=
F=82=AD=82=BE=82=B3=82=A2=81B

=81=A5=82=A8=8E=E6=88=F8=96=DA=93I=93=99=82=CC=8Am=94F
https://xdvivoice.com/ainsbury.html

=81y=8Am=94F=8C=E3=82=CC=8E=E6=88=F8=82=C9=82=C2=82=A2=82=C4=81z
=8Am=94F=8C=E3=82=CD=92=CA=8F=ED=92=CA=82=E8=82=A8=8E=E6=88=F8=82=A2=82=
=BD=82=BE=82=AF=82=DC=82=B7=82=AA=81A=8A=FA=93=FA=93=E0=82=C9=8Am=94F=82=
=A2=82=BD=82=BE=82=AF=82=C8=82=A2=8F=EA=8D=87=81A=83A=83J=83E=83=93=83=
g=8E=E6=88=F8=82=C9=90=A7=8C=C0=82=AA=82=A9=82=A9=82=E9=8F=EA=8D=87=82=
=AA=82=A0=82=E8=82=DC=82=B7=82=CC=82=C5=81A=82=B2=97=B9=8F=B3=82=AD=82=
=BE=82=B3=82=A2=81B

=81y=8Fd=97v=81z
=82=B2=8Am=94F=93=E0=97e=82=C9=8C=EB=82=E8=82=AA=82=C8=82=A2=82=A9=82=B2=
=8Am=94F=82=A2=82=BD=82=BE=82=AB=81A=95=CF=8DX=82=AA=82=A0=82=C1=82=BD=
=8F=EA=8D=87=82=CD=91=AC=82=E2=82=A9=82=C9=91=CE=89=9E=82=F0=82=A8=8A=E8=
=82=A2=82=B5=82=DC=82=B7=81B=8A=FA=93=FA=82=DC=82=C5=82=C9=8Am=94F=82=AA=
=8A=AE=97=B9=82=B5=82=C8=82=A2=8F=EA=8D=87=81A=82=A8=8E=E6=88=F8=82=C9=
=90=A7=8C=C0=82=AA=82=A9=82=A9=82=E9=82=B1=82=C6=82=AA=82=A0=82=E8=82=DC=
=82=B7=81B

=82=A8=8E=E8=90=94=82=F0=82=A8=82=A9=82=AF=82=A2=82=BD=82=B5=82=DC=82=B7=
=82=AA=81A=89=BD=91=B2=82=B2=8B=A6=97=CD=82=F0=82=A8=8A=E8=82=A2=90\=82=
=B5=8F=E3=82=B0=82=DC=82=B7=81B

=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=84=AA=
=84=AA=84=AA=84=AA=84=AA=84=AA
=81y=82=A8=96=E2=82=A2=8D=87=82=ED=82=B9=91=8B=8C=FB=81z
0120-058-098
=81i=8E=F3=95t=8E=9E=8A=D4=81F=95=BD=93=FA 9:00-17:00=81j

=8D=A1=8C=E3=82=C6=82=E0=81A=82i=82`=83l=83b=83g=83o=83=93=83N=82=F0=82=
=E6=82=EB=82=B5=82=AD=82=A8=8A=E8=82=A2=90\=82=B5=8F=E3=82=B0=82=DC=82=
=B7=81B


