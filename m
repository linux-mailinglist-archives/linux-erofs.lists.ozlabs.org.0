Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2439397D811
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Sep 2024 18:11:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X9HT44DMYz2yXm
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Sep 2024 02:11:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726848710;
	cv=none; b=cgyySi8ghZsgZoX1N3k0kSa5LdnCqEBzS3ITF+5GsujS7Vvrh3QY5ectFSlNaY6M8BAM9XiCWGGLAnYc5loQcszxqnzU/5wyfzlyA09G1SlR5guyd0WpsxmA7FWXnJz6iOa/iu/0jL0krVvjrgTAyxquaVGSLdvfBiDcMrXkAmaz/Amb46XjWbvZQ6JyL4Myy3lsHfAtxA7U/ukJGzR/EheQJjDs7ISOH4W3/wzzGbnJIwtKh24y/7tiFkFz0+R7VPCJtyPOfR/SywWylqsqPVbpEOm0SVASOQZVkHJeGYCuZeXQfftfn8rrS91oHXtCj46CodfhgYOxjbiLiDlBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726848710; c=relaxed/relaxed;
	bh=DDCFdwfSzQys9/FLX8CaxepnpWlXD3khIsZd4D4f4G8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=oqRMHoRHS3sBEQYXiyldWgdpDbyqyk5Q262qvmsGB/aXyYx1M9y/XhG0FmtcTV0PrNm8R6i2Zoh6uFwpAJ+nVXzc9KN0qLBjbKvWfraK5eTW0dYRmJuz2JIGLflVbuVFHPlNheHCS2lkuV+zVuqK75KFidj6BW7rNbyEDBGFoaPUOeY657m52nb209P45o6CqTWvMWylRBAWmMrIKl5VY+RvxXR/TS2CSsAdN6YqKH+tz5OfctIAhEjIngLrZsbJbXvYa7qP+zVGSW8jl81JVvgB6nXnU8zqAxSFoS+nwQk23KNRoKiP7+642xWEKp+5t1RDRQH9f396GsxLF6oqxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com; dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=NzIOjiPj; dkim-atps=neutral; spf=pass (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=fred.lotter@canonical.com; receiver=lists.ozlabs.org) smtp.mailfrom=canonical.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20210705 header.b=NzIOjiPj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=canonical.com (client-ip=185.125.188.123; helo=smtp-relay-internal-1.canonical.com; envelope-from=fred.lotter@canonical.com; receiver=lists.ozlabs.org)
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X9HT0457gz2xs7
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Sep 2024 02:11:46 +1000 (AEST)
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 878353F1CC
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Sep 2024 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1726848703;
	bh=DDCFdwfSzQys9/FLX8CaxepnpWlXD3khIsZd4D4f4G8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
	b=NzIOjiPjSulJVkrFNhgfVJszrBLCuOebNy7uSzJqc66rSjGSxFbkNV80w4i3XzeRv
	 sLnFYIpMuvt7q+pNN9MnQ+4JORE33O8Q5ke5S6LGhlR96OC1Jt6LqP+Vy4PkWf7eg3
	 awhj0/ZUQTyRxeOIY8OuIYLEpYdM0DSAsFeK9YUpHH5TdKuMrn7SrevR7hXqoqDcoL
	 AYhlCgTwFH9zsrT2QQIQXTU70Pw2SkXsjar+xruhNchHKHb7aQXcDtFT2GL+E+Fc1n
	 WS56P9YOpz7AM//LEeWLe7ZZD2iToBDmtQ1uyRqeP6pN0lKl5DhHAJB2wlssLSxWHy
	 CfzmKVAvjp9uQ==
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6c5984bc3fdso24460096d6.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Sep 2024 09:11:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726848702; x=1727453502;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDCFdwfSzQys9/FLX8CaxepnpWlXD3khIsZd4D4f4G8=;
        b=Pey7g64jvMhcGG7FV70E+UeLCKsvcURQjYogMuMnquzlDI9HI6wIiLbWJaNCfLDoJV
         N6XVL+gFUvS0xBdtwugHQV8mB4vg7UZw3LLKCcensskmVJan1x9iF9e/uA8e+6gE6rkP
         WbliHPkbCo42UqrF27DZdCRgGx7Kwb0+evfx1G/Wt1G/z/dJvp2nDXZjZ00QkAGI1qS3
         EO1VNrV+ZZ95F6HhIo0QFj+OkPpLJHjKblJF0mwgaQAqgH/f+nA9GnOS3ipotm8iRYa5
         V0pGbySJ9P/OB2S7mCQW1VqiPgNL4MT0wGG65oYelTO0A1Jx/kZjnXJ4yc6glCU8POi5
         tqhQ==
X-Gm-Message-State: AOJu0Yxu3/mghQU0xLM0hDhIj8C4xYqHZXAoiKTY/ayIAHzUnJiUKPyL
	OY1JIajuxz4Xpul/4ypXIH1bUZirXucsSQMs6YN0y0BDbosW+ol8Uy5TcBwnD1QtAzenvF9/v1W
	vx9lRuq3EjzuiCGREpd6bHot7/+ie4JCx+zbdDNTwYEikFl0wJGrx/fu5x2qhjbqtuWhBFvdPlj
	ZIaXTeL2W0IQNllVPvGkpTITP2JG462VwDf69cKGvLOSnPm2pJXnrj8GSncWyQAGE=
X-Received: by 2002:a05:6214:2dc2:b0:6c1:70c8:ead6 with SMTP id 6a1803df08f44-6c7bd5b9113mr40616716d6.50.1726848702427;
        Fri, 20 Sep 2024 09:11:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpFxLfxheiosQFuoLcNuKiKiiN8Gc290djgmzJxP3aQ3g+Thj4hD7qs914ABzfH+qxbNZl0c4wvvW4qXStro0=
X-Received: by 2002:a05:6214:2dc2:b0:6c1:70c8:ead6 with SMTP id
 6a1803df08f44-6c7bd5b9113mr40616326d6.50.1726848701763; Fri, 20 Sep 2024
 09:11:41 -0700 (PDT)
MIME-Version: 1.0
From: Fred Lotter <fred.lotter@canonical.com>
Date: Fri, 20 Sep 2024 18:11:31 +0200
Message-ID: <CA+yndwhjTkF_D1QZ3UDLggAXXGen_fLr6rLvBVS8tYw3ViH+8Q@mail.gmail.com>
Subject: Help with EROFS for specific test scenario
To: linux-erofs@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000073343906228f4b5f"
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--00000000000073343906228f4b5f
Content-Type: text/plain; charset="UTF-8"

Hi,

In the context of this page:
https://erofs.docs.kernel.org/en/latest/merging.html

I am trying to experiment with EROFS where I want to try something crazy
like the following setup:

/dev/mmcblk0p3:
|
EROFS root image
|
--------
|
EROFS second image
|
--------

I wanted to have a primate root EROFS filesystem written at the start of a
partition. Then I would like to "append" files to the immutable root EROFS
filesystem, by adding a concatenated EROFS filesystem after the root
filesystem, with an external device reference pointing to the root EROFS
filesystem.

My idea in my head was then to boot the Linux kernel with something like:

root=/dev/mmcblk0p3 rootfstype=erofs
rootoptions=device=/dev/mmcblk0p3,offset=<root size>

1. Is it possible to have the "blobdevice" point to a complete EROFS
filesystem?

2. If yes, is there userspace support for creating this setup?

Kind Regards,
Fred

--00000000000073343906228f4b5f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>In the context of this p=
age:</div><a href=3D"https://erofs.docs.kernel.org/en/latest/merging.html">=
https://erofs.docs.kernel.org/en/latest/merging.html</a><br><br>I am trying=
 to experiment with EROFS where I want to try something crazy like the foll=
owing setup:<br><br>/dev/mmcblk0p3:<br>|<br>EROFS root image<br>|<br>------=
--=C2=A0<br>|<br>EROFS second image<br>|<br>--------<div><br>I wanted to ha=
ve a primate root EROFS filesystem written at the start of a partition. The=
n I would like to &quot;append&quot; files to the=C2=A0immutable root EROFS=
 filesystem, by adding a concatenated EROFS filesystem after the root files=
ystem, with an external device reference pointing to the root EROFS filesys=
tem.<br><br>My idea in my head was then to boot the Linux kernel with somet=
hing like:<br><br>root=3D/dev/mmcblk0p3 rootfstype=3Derofs rootoptions=3Dde=
vice=3D/dev/mmcblk0p3,offset=3D&lt;root size&gt;<br><br>1. Is it possible t=
o have the &quot;blobdevice&quot; point to a complete EROFS filesystem?<br>=
<br>2. If yes, is there userspace support for creating this setup?=C2=A0</d=
iv><div><br></div><div>Kind Regards,</div><div>Fred<br><br><br></div><div><=
br><div><br></div></div></div>

--00000000000073343906228f4b5f--
