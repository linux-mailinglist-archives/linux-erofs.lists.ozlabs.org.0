Return-Path: <linux-erofs+bounces-2969-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMWuL5mowmkyggQAu9opvQ
	(envelope-from <linux-erofs+bounces-2969-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 16:07:05 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C75C9317AFD
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 16:07:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgD0Q1PQ0z2ynW;
	Wed, 25 Mar 2026 02:07:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::b12f" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774364822;
	cv=pass; b=Z7/J/gsmbcMTnf8iVn4HERRbAZHK+hGao11qq8M0/WvFxUQtmp6b5XSXsdmJ4Gx+8pr7JtkUjrz7aXGmqIm/eXbd3Mq62l+xKLX7jhyBrGRD8SgFEtcSqc0CFdkGdENm5fH5LEwEMq020VJRgGlj/VsddnhE3kBLXymdfIbUx6C6ISNXcjVIZb83xcFk4SGZOJyLJHShRBYd7j4g2sFaaYaHg6ksqeO8sG8rd8Nww1N4rS4DGFjscDhkVLEBXMCBc7Huxx68wZP2MHu9GupvAS662JmaiSoEnZnjs0FNLTdzT0TdeBrzd/YZvNInO+MV7xOIQy3N+1xmkIfuJ9f5aQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774364822; c=relaxed/relaxed;
	bh=Jtobgn6m1i9WIEefyVr/3hr8MZ8VNy+yIPLUtSik9/o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oVd6nJn35kveNBJMTkZZvxyhTT2rpnTR5ZtXeoOdYtJACqqJaD5QUNP9R2r3KEuP2YfAXGDeKJ2kMHH+GqFDuE/gWGdXMDev/RQAc5NeSAzMv8zsAjxE8coq3W/vOpJFPj56Bi6ur3PjL49g2LQ3B3BoJjkpryIMqR+kblvqC3RCRYftwmhUaanQL45XyiFmYHNeA8MLlsBy5g20Ga/hZr4OKqNkspnhLSpaQNc3NEr5tpamXPcA7hLJtEVszvheH/8DxRd4MdfN6U/1sh8oOyiZM0KbG3Y8RGTqZ1PGqMYGiA80uWeA5h/ZzRZdAx+YArYJLqz8ujB5ula3TElnkQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlF09icw; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=udishanarayan646@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HlF09icw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b12f; helo=mail-yx1-xb12f.google.com; envelope-from=udishanarayan646@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-yx1-xb12f.google.com (mail-yx1-xb12f.google.com [IPv6:2607:f8b0:4864:20::b12f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgD0N6wtMz2ynP
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 02:07:00 +1100 (AEDT)
Received: by mail-yx1-xb12f.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso2022474d50.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 24 Mar 2026 08:07:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364818; cv=none;
        d=google.com; s=arc-20240605;
        b=bZEnJuSlImHHbtRrpbuS78Fi8rfc/voQXZ/SurlOEsiyTsiYun5amqjBw8qNUIcarR
         h1Qcvgqa01Oha3d/L/CSMIVZa7JrIj4Y3R9vFGTGf1eEA1Y3Bfk7Nlch7XG5wi4lAJG6
         63RbHuSo5+dZTkxc0KwKcpsviousM7jCFJfRhPkBVIwxQy+sFxSH8l4zrfUCENMCKZA6
         ayNM/UeYnxCXyBb0w+8+wupK1jmGrQU8JcdTZMz91zjU2ipOrovo6fnAzBEEEde2yByl
         c/4wn1g+wGO7oQmhQ7gZA3/1Oxp0P0Uul2tClk3Z5K7IDLaaUVUan/ksqEPY7+0RWPsm
         SM/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Jtobgn6m1i9WIEefyVr/3hr8MZ8VNy+yIPLUtSik9/o=;
        fh=wOhGMmq2KH+KOElLlPuS8ws9o9ArjDb4wH58JVHh4Vg=;
        b=ERz8KM7cbxQ64WdcO62lIGEbXj6qCdZRdwH3SdEnStEw5+NxyK4gMUt3IBIgQ/6noQ
         bIRv9oHPWddmRR+7Ij3pzp1pIn52qLmqyRM4lqRuIeSWb/5Ru4ZFsSf/SlJ+azMDjYvh
         /w1r2OdFTsX3uRs+ECOADnrzS2c6zm+l17Lk+x2G++RLH4rR1JOQ45Di8l0Gwv5cSY+f
         uHUfNaw8NmqJ+cfGV6DPc2GkSBKafOZkzWbA8/Pg3G9CxiAhZW4fXKYG90oGXNlA+nk3
         V97TFTbTnkWpiNpahqiTz1HPBsKxGPg1twovelMdyF9fSaKOJ5Mi0crtpWZN6WgTyINR
         fGSA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774364818; x=1774969618; darn=lists.ozlabs.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jtobgn6m1i9WIEefyVr/3hr8MZ8VNy+yIPLUtSik9/o=;
        b=HlF09icwg71IMwZIB7wyVeq8V/rGeT6jj0gA7rlXZylPFJ71ERnLDdJZ9jNW90vBiK
         ZJWjtOCD7T31Nt4wtpZHWi8D60m6SSYlZc4bg4E6AFEMU9iiKA0ID6tZBL/kqe3K19Vo
         2E+vBFkQM1StZerV90PisCTSzEQwBMkk9VoQR3TipByo52p4udRDSR2QerFf1UhiQMI+
         RUyfgdJZdVRJIM8qqxlps80LOEXA2MEeqoTsCY/jjsQXassVzh06fw/sq1FLq/EicT9l
         ixzMLSqqTpKe1WPAr68UIHmB7K4fpEaICTbExwzYyDTBBgqXYEQqwmHdtuhaglwFr6vj
         W3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364818; x=1774969618;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jtobgn6m1i9WIEefyVr/3hr8MZ8VNy+yIPLUtSik9/o=;
        b=i3TEvRvSLGH17skPMVGnyXT57l/nZxbibQ1AiCgN2ceoMCRunPfnSuH/5yVA9iUBqO
         LKI8TdepDSzBhBB0hWYUrZPWEiT4mdBbd3qFoWypzLf0/ukG7MCiNwD33I618efUZYdV
         iQQE+0tnLMRsig45tg18k0FiCD3/gkm3ILI1WEFKe4yBaB2oSK6gj+fYmpEKzBliyWTd
         KsQ505orBf9ACY/ZjrzihJR+hZwK5UuAEjf+qGp8HQJZVdFV5dFoerUNiiJBiGzl5xtz
         ZO4+OiXAICBGF9bSoP/Wxn8xPAMpp1xFRR9EnnvLeoTa9JFwRcq9qesleZLFbY4jRSCB
         Hubw==
X-Gm-Message-State: AOJu0Yzu1s7cxP05khsLqZgyk7VFvSjjsc9rTUJ5DJahAatGO4Vu4WlK
	mJaYhxvVcSYRbAl+ZRK88BgXjWGVA3wPhiK5Ps807W6BtWodhx+7f3pAAOujEKr1hnIATBKdrzj
	GAa2KmNcWJKXbQZyfbTrdPnCcruLUhYrIcmjg
X-Gm-Gg: ATEYQzyM64MYPeyuNFcLBAa7L/bMkeQqZB7b7s5kxP+6ZaqxasJ0/kmcjjdKfPTond9
	X6dsw0nZzTZ90ho39S9Rhm3Z0EPIOlZ5ylpFOV+FNVWCH91v8NqvoIHzqOk/GfMgK2W+deAwkwF
	oTaq13ZT4XjIrCI6wQ+oxDNE3FSsV66pvMFcrwX+hkNSK65KKRC0Hbf9y33SFlZP4bB05kOoSIX
	tTqo+iGi+xKm7jGzEz8z47o/lIQ1yNmk3vc4F2opanM+LJCXF/6FdGUBJzgY8XgzQTURLBKweOr
	u8BPm+vyZPKMLfbvwsPzR+2GCFJZqi5VgvRmJyy+
X-Received: by 2002:a53:ece4:0:b0:64e:5da9:71cd with SMTP id
 956f58d0204a3-64eaa6bed15mr12777736d50.21.1774364817421; Tue, 24 Mar 2026
 08:06:57 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
From: Udisha Narayan <udishanarayan646@gmail.com>
Date: Tue, 24 Mar 2026 20:36:28 +0530
X-Gm-Features: AQROBzA2Mc21hWVmCJB1JcVtjXSd5OmWG6GMLwccMP7iZc10noDO_PFkIfOKJK4
Message-ID: <CADVXez_zfMSTL4S6O0M6oKj448S+ZH5fEDCd1PeB5=fFuRvVxA@mail.gmail.com>
Subject: GSoC 2026 Inquiry: Interested in EROFS-utils and File System
 Optimization - Udisha Narayan
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="000000000000a4fec0064dc68008"
X-Spam-Status: No, score=0.1 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-2969-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_ONE(0.00)[1];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	MISSING_XM_UA(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[udishanarayan646@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: C75C9317AFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000a4fec0064dc68008
Content-Type: text/plain; charset="UTF-8"

*Dear EROFS Team / Gao Xiang,*

I am writing to express my strong interest in contributing to *EROFS
(Enhanced Read-Only File System)* for GSoC 2026. I am a Computer Science
student with a deep fascination for *Systems Programming* and *Linux Kernel
internals*.

*Why I am a strong fit for EROFS:*

   -

   *C Programming & Memory Management:* I am comfortable with low-level C
   and understanding memory layouts (Pointers, Structs).
   -

   *Mathematical Foundation:* My background in *Discrete Mathematics* helps
   me visualize complex data structures like B-Trees and Bitmaps, which are
   crucial for efficient file system metadata management.
   -

   *Optimization Logic:* I have experience analyzing code for performance
   bottlenecks (C/C++), and I am eager to apply this to *EROFS-utils* for
   better compression or faster read-only access.

*My Goal:* I have already explored the erofs-utils repository and I am
currently setting up my environment to build and test the tools. I would
appreciate it if you could point me toward a *"Good First Issue"* or a
specific area in the 2026 ideas list where I can contribute a small patch
to demonstrate my skills.

I am ready to dedicate *40-50 hours/week* to ensure a high-quality
contribution.

*Best regards,* Udisha Narayan [GitHub Link] | [LinkedIn Link]

--000000000000a4fec0064dc68008
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p><b>Dear EROFS Team / Gao Xiang,</b></p><p>I am writing =
to express my strong interest in contributing to <b>EROFS (Enhanced Read-On=
ly File System)</b> for GSoC 2026. I am a Computer Science student with a d=
eep fascination for <b>Systems Programming</b> and <b>Linux Kernel internal=
s</b>.</p><p><b>Why I am a strong fit for EROFS:</b></p><ul><li><p><b>C Pro=
gramming &amp; Memory Management:</b> I am comfortable with low-level C and=
 understanding memory layouts (Pointers, Structs).</p></li><li><p><b>Mathem=
atical Foundation:</b> My background in <b>Discrete Mathematics</b> helps m=
e visualize complex data structures like B-Trees and Bitmaps, which are cru=
cial for efficient file system metadata management.</p></li><li><p><b>Optim=
ization Logic:</b> I have experience analyzing code for performance bottlen=
ecks (C/C++), and I am eager to apply this to <b>EROFS-utils</b> for better=
 compression or faster read-only access.</p></li></ul><p><b>My Goal:</b>
I have already explored the <code>erofs-utils</code> repository and I am cu=
rrently setting up my environment to build and test the tools. I would appr=
eciate it if you could point me toward a <b>&quot;Good First Issue&quot;</b=
> or a specific area in the 2026 ideas list where I can contribute a small =
patch to demonstrate my skills.</p><p>I am ready to dedicate <b>40-50 hours=
/week</b> to ensure a high-quality contribution.</p><p><b>Best regards,</b>
Udisha Narayan
[GitHub Link] | [LinkedIn Link]</p></div>

--000000000000a4fec0064dc68008--

