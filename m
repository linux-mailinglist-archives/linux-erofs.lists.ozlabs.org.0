Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 294F594C371
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 19:15:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1723137352;
	bh=pwmNcc8bpf+pjQ56TVquIu8vEj+pX/2E65Df4kEMq/I=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=eTZUNQhWzCWR3ADb9mbg1D8CYtWQWX9807hTHcpJCgG7P1p85W7TG7eLmBdGpF95/
	 rVZcTYG05+duMvIWa4WGZl9blordwFn/wR++Us5B6GZev1GDLFjg9vx35s/Nj7z0Fu
	 DoPZVfjC6qXYxKum/pMjOmwMVLvyTiQNjHR+HBDrMdiQG1nZbMHZKrBjs+g9/lDYJ8
	 S+Z+IKHxa9CV442SwNnDbYvPS/y1IkvgSXLOEjOnZJzvUTeWuPDXI3SDt+vQwBq4nA
	 ws61XvsSxS8abnOWCpo0IOOvwvodMy7OJn5yOvwco5rcdkwD0Tfowc7PjFlcdT1W8o
	 AQg5kB+YDqoBA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wftwm6Rsyz2y1W
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 03:15:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=WRpZ9DHm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wftwh3qP8z2xgX
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 03:15:47 +1000 (AEST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-4280bca3960so9031625e9.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Aug 2024 10:15:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137343; x=1723742143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwmNcc8bpf+pjQ56TVquIu8vEj+pX/2E65Df4kEMq/I=;
        b=YscEJEW13/HWBwef9dHDORdTZHgNAiG7TQMyb7KYXfBK0QBVZlthNiCpX1rLeX4XrA
         5axIO9PjH+xA9cOcy0gtWeANBDlEr4vcQn/+2gg/oVZe8gPzM3GIEMyI4wIijuROX0gC
         OnPlhwSATIljU5mrZoAg0GWNtHNwLzk/HAwAmqEcinGdoyD8YRRx+5w6KX9Q/wmXLRAs
         vnVU7h06sTJs26SrG0KKpl2p7xfSKl1UoMkr+aifQGFyYeuuR3F/BfHMq4C7gNkTE34V
         aPSSLc0Vy/v/eIR1druDFTaX529E3YnNQS89k22wDpHoz4CLF2ptSYFzwxvtoQDQrMoq
         derw==
X-Gm-Message-State: AOJu0Yyj1cbeiI0hL1ofAUMtkAJHoi2KtJFiHbYZlzjyG1j1SptvFtyg
	lIRGfFjlNNGJOTVD3KA/JRnn+0EOXo8VwhhKhK21dlB0c1JCsM6dCPLhBe5jg8TbNPhdSlHTPe6
	Q//ZCu8GU7vjQTX+eSTo3MfmgOysNEDQ9/zohoYxqHrsc8XtI0RyK
X-Google-Smtp-Source: AGHT+IE6DNwcsVFPJ3Zbb3hieVZtDXxiTQWT5/ZTF+Yij5M1o3Zw5MyiCTH6LtMebLpODaiwtDe1dySGZWyELmw0ojc=
X-Received: by 2002:a5d:4a02:0:b0:368:526d:41d8 with SMTP id
 ffacd0b85a97d-36d274db762mr1742797f8f.23.1723137342955; Thu, 08 Aug 2024
 10:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240808160343.2544426-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240808160343.2544426-1-hsiangkao@linux.alibaba.com>
Date: Thu, 8 Aug 2024 10:15:31 -0700
Message-ID: <CAB=BE-T-d-vjad6Q1kLeQbSr5pcSQCfX15vKxYvQJOqPncG32A@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: lib: fix global-buffer-overflow due to
 invalid device
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Aug 8, 2024 at 9:04=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> Fuzzer generates an image with crafted chunks of some invalid device.
> Also refine the printed message of EOD.
>
> Closes: https://github.com/erofs/erofsnightly/actions/runs/10172576269/jo=
b/28135408276
> Closes: https://github.com/erofs/erofs-utils/issues/11
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  lib/io.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/lib/io.c b/lib/io.c
> index 6bfae69..fbeff03 100644
> --- a/lib/io.c
> +++ b/lib/io.c
> @@ -342,6 +342,10 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, in=
t device_id,
>         ssize_t read;
>
>         if (device_id) {
> +               if (device_id >=3D sbi->nblobs) {
> +                       erofs_err("invalid device id %u", device_id);
> +                       return -EIO;
> +               }
>                 read =3D erofs_io_pread(&((struct erofs_vfile) {
>                                 .fd =3D sbi->blobfd[device_id - 1],
>                         }), buf, offset, len);
> @@ -352,7 +356,8 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int=
 device_id,
>         if (read < 0)
>                 return read;
>         if (read < len) {
> -               erofs_info("reach EOF of device, pading with zeroes");
> +               erofs_info("reach EOF of device @ %llu, pading with zeroe=
s",
> +                          offset | 0ULL);
nit: typo carried over from previous log. s/pading/padding

>                 memset(buf + read, 0, len - read);
>         }
>         return 0;
> --
> 2.43.5
>

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
