Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 521D683718
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2019 18:36:02 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4630cv6G0PzDr27
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 02:35:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.com
 (client-ip=212.227.15.18; helo=mout.gmx.net; envelope-from=hsiangkao@gmx.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 secure) header.d=gmx.net header.i=@gmx.net header.b="T0FfVdbX"; 
 dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at bilbo;
 Wed, 07 Aug 2019 02:35:49 AEST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4630cj5wJFzDqrW
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 02:35:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1565109343;
 bh=OKJ6Bjq0pdODNE0rerFhIjfk8FpULoo7FFZuga/aehU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=T0FfVdbXT1rimwmpMxCaNbzDrAAQSsGOws0S+g7KwDbNlNUIGVvG0+tksc0D9icOH
 s+i+3nvb7Q1A0WlfhxzV3QsZH6prf+lQKn8r0hcHdrvqnFFA4uO6TlPUl6DXXUmaPr
 3/lcJGp0hoU3pPaRKkd35+fPnwdgOC8mD/aXZbo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from hsiangkao-HP-ZHAN-66-Pro-G1 ([60.177.33.208]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MWRVh-1hokiU03pL-00Xpwa; Tue, 06 Aug 2019 18:29:57 +0200
Date: Wed, 7 Aug 2019 00:29:48 +0800
From: Gao Xiang <hsiangkao@gmx.com>
To: shenmeng999@126.com
Subject: Re: [PATCH] erofs-utils: get block device size correctly
Message-ID: <20190806162947.GA28162@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <1565105005-21709-1-git-send-email-shenmeng999@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565105005-21709-1-git-send-email-shenmeng999@126.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Provags-ID: V03:K1:6xFMaKTK48cHTOA8IQNfD5tlfBFi5o8Wgt1zWaJ2CTeGlMOt3t1
 g9yE7znIN15AC+Xqw+8hQCoywRr03OAqQX7N07KbEWlvHBEZqY4a6c0Gps5GdfW4uY0QI6o
 tfp6Zdu1gJ7ZkGcNXiDyhJRC4GdzU7BQkNHqSnRkInR3eH/gZRls5YNBVLOTlc+rwFosDoI
 oH3MLE7KclWhVQr8Tp3XA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:OCodbY6eXeY=:cmA11PuZKM3NwWf+rBdxc9
 OSVTZqPj4ylv0KL6Pwgr/2tfSJH0r/X0F/hwfq/yjjUgabPX08OiI6uWzV90AZNJIgDfj0Em5
 YYmMiSruPXzYyEalYwEUWYvKGiEYSuGJTPEOggvYqXvPNp+IzByuOYgaUD2toicc8mus2Ah90
 weWHQp5b4DqnH5F8SzorKFm0JUXtoyRBzWjIwAZa5i0es7qWJafW0COxi7HcsNJ+9ntcWzSnT
 gyIUZXiZlJY0+AsVAfMdcHqF35dvxG85sdFrqXLrBSbLo9794C3gk7+UmIge7g9FhNS8d5ypy
 h7LIi5IOZ3zwo959a5Czts3/3V301aFYnizSez5sEP0frciTM60MPTi6Mk68w1fz1bgDZHcpv
 LHPew6uuUEfLys/I6YZfiGkThjuFX5UkXYnYG/q0DWNByFPtYi6vy7rB2hKqY+SIiYCD6Wb8n
 DVmKNY34+saxfBg+sIGnNHjVgqEEK/uh+pj3cd+4X1rQ0nsYM7h2R84ezuCQC4lmW2uW9pwFg
 8oDIxJmVvZjHU9wXvYyH0QVh8JZhf+AjvUNYkI6ra12ZnGD+2o1ytdR/gbXQ0XKx6ymkQUyTb
 R6CtsYeB8OcRcR0ycXvXjKdbTFg478y4ER7LhbFys6f9rnIV4VfGkcbHxvF78/xM8Bl1/CIvU
 6N+k/EAs2aG4xg55V7XjNoYY88fad1raH340YVflBxDlYuh7locmPs3tvG39nWHg/2ZpB1nUM
 +UIq+R7aVp3GMBsnOMh98CWWlILrWemf/2J3piKnNeeTqbJogReD2UjCMi1gNORT4j57uswlO
 CM5jDEVQHEgK4685R+2CXHnQyU87uvBDt9TOkYuUjprSD+4Hbq/lrc5UI/hv1Rm0IexsqK4Bj
 5bKbBCVDXiTWPcPL0Hk8jFJVCgyNgZniFu6bt76yvk1dUj9XuOhioh5/hM3vvG+KKtP4LEJP4
 ABiV0lj60lyE76m7hAGPW6sVGOoO6AqyJ27a1sY1FsJT0HUScpbJXFBO/H4sl2MzKGSCeyVem
 /A6P1fAW31b7hF7Zi4+qFb5qtwQRcr+dYyhp5qLaBrH7QnDeAbmWwlVTtwJ2VJDAzUAobqCpt
 iTNLQr2snA/oJ9EOkzwt8jGVxef1lKIbkLjhPlE+aI56llVgAB+5kVl/Q==
Content-Transfer-Encoding: quoted-printable
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
Cc: miaoxie@huawei.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi shenmeng,

On Tue, Aug 06, 2019 at 11:23:25PM +0800, shenmeng999@126.com wrote:
> From: shenmeng996 <shenmeng999@126.com>
>
> fstat return block device's size of zero.
> use ioctl to get block device's size.
>
> Signed-off-by: shenmeng996 <shenmeng999@126.com>
> ---
>  lib/io.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/lib/io.c b/lib/io.c
> index 93328d3..ae3ac37 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -9,6 +9,8 @@
>  #define _LARGEFILE64_SOURCE
>  #define _GNU_SOURCE
>  #include <sys/stat.h>
> +#include <sys/ioctl.h>
> +#include <linux/fs.h>
>  #include "erofs/io.h"
>  #ifdef HAVE_LINUX_FALLOC_H
>  #include <linux/falloc.h>
> @@ -49,7 +51,12 @@ int dev_open(const char *dev)
>
>  	switch (st.st_mode & S_IFMT) {
>  	case S_IFBLK:
> -		erofs_devsz =3D st.st_size;
> +		ret =3D ioctl(fd, BLKGETSIZE64, &erofs_devsz);

Thanks for your patch :)

I got some reports of this issue months ago, but I'm afraid
that we should support the legacy BLKGETSIZE approach as well
as what other filesystem userspace tools do...

Could you kindly take some time to make a full patch of it? :)

BTW, from the point of view of use, it's better to generate
a image file indirectly and `dd' to the real device rather than
directly use block device as the output since erofs-utils
will do unaligned read/write even overwrite, which isn't
very friendly to flash-based devices...

Thanks,
Gao Xiang

> +		if (ret) {
> +			erofs_err("failed to ioctl(%s).", dev);
> +			close(fd);
> +			return -errno;
> +		}
>  		break;
>  	case S_IFREG:
>  		ret =3D ftruncate(fd, 0);
> --
> 1.8.3.1
>
