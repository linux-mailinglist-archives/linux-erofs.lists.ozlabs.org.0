Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C9E8708A3
	for <lists+linux-erofs@lfdr.de>; Mon,  4 Mar 2024 18:51:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1709574691;
	bh=xOCRP+fJrD0G9ssZRMbCTHT/LFXOIHP8hjgv3KWmrE0=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=H/4TZOO/o+EPswtOLkcKoDEd32ENesT5W8NRxhfTM9KyxBz2soQrzn1vcg+OloZnz
	 lEDzCAGVotUTww9A7uownVpExk5E3m9Ayw3oS0IRSYDeXyN84EDHmzNjaPp/0JfDEx
	 rFZHjWCoRGGb12BL8Nl3j28ul9BlwLU9uW+Fzy++k5OlmrJRL2cDrCIXjl/WG8o9f6
	 sLbxgN75mgbcgf+kRh+tM7Z4X7NQjqQPkcgblENE8HYW5j9sEmUn3Eu7IdJHHcaF6z
	 TFBTKJm4nHh5HBWQv4CTKdutUkThSetqnh2NaTFmIBb0MojSHVbHZ9UI2QLl8VUTUf
	 julHernnGCkdA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TpR8M5r8Nz3d2w
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Mar 2024 04:51:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=sAasxZFe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::429; helo=mail-wr1-x429.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TpR8F6Tn7z3cDT
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Mar 2024 04:51:25 +1100 (AEDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-33d38c9ca5bso2407723f8f.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 04 Mar 2024 09:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574679; x=1710179479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOCRP+fJrD0G9ssZRMbCTHT/LFXOIHP8hjgv3KWmrE0=;
        b=NiuZsy6XJC+VIqmBKisjG63Ujh5BO4iYcCc1RdiN2guMQkqzjCrFvGQUh6vq3ElU8q
         X/qQ6H8n/ChCM3iXMJhQCr+5Sa2xZqmdlHsgvebrSsNjd2HQ4SEaNyjeJmrdGKlSXGDF
         koN1MwJmr1l7r2fKjfyXOtlv3Ns1V37pO5BVcQAi8un6+gC9KjLA3A0EP58/MJZdzvW3
         FtljOugmCtaVvt9rBmOUtL9QfwNeFwjK0XTOkFaLzWknbJIjjXbYxKHaq1cPlska7UxP
         0j1k1mBJ9PktP1mjLfBf4RYX8fNAou0b1cEc0S9/zxf2r1XyBGa6wg+vHJ9Iv/st0HUI
         HvLg==
X-Gm-Message-State: AOJu0Yyaofy8aHNX+1eLr76RTwfBdVqUWTdfdSHTBU+vh0rHXtq/BgmO
	A3vsjaUcnNNzKHjso3WUWLXkwvYOMfIDd/CwWsqr0KVJL9LXl5uoUy61iVV4Lh25eRnpxCKACfy
	3c0wyHWBAVhd3wUharJ/iyczTvWepiNQL2a2Y
X-Google-Smtp-Source: AGHT+IG8OcFIwLQ1ch8T5SiElzbSL6ZWVmZp/xgRrugYGmXZy323LCxt0wnKZMvqtlBTLXN8pHKQLJx3H1EW18EyW4Q=
X-Received: by 2002:a5d:4f07:0:b0:33e:11c3:7ebf with SMTP id
 c7-20020a5d4f07000000b0033e11c37ebfmr7001268wru.62.1709574678572; Mon, 04 Mar
 2024 09:51:18 -0800 (PST)
MIME-Version: 1.0
References: <ab2a337d-c2dd-437d-9ab8-e3b837f1ff1a@I-love.SAKURA.ne.jp> <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240304035339.425857-1-hsiangkao@linux.alibaba.com>
Date: Mon, 4 Mar 2024 09:51:06 -0800
Message-ID: <CAB=BE-SJ_KoR0Gb+K2YNLYrP2q1b=WscMR-z9HLCdeTgHE8-qg@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix uninitialized page cache reported by KMSAN
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
Cc: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, syzkaller-bugs@googlegroups.com, LKML <linux-kernel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huaweicloud.com>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Mar 3, 2024 at 7:54=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
> syzbot reports a KMSAN reproducer [1] which generates a crafted
> filesystem image and causes IMA to read uninitialized page cache.
>
> Later, (rq->outputsize > rq->inputsize) will be formally supported
> after either large uncompressed pclusters (> block size) or big
> lclusters are landed.  However, currently there is no way to generate
> such filesystems by using mkfs.erofs.
>
> Thus, let's mark this condition as unsupported for now.
>
> [1] https://lore.kernel.org/r/0000000000002be12a0611ca7ff8@google.com
>
> Reported-by: syzbot+7bc44a489f0ef0670bd5@syzkaller.appspotmail.com
> Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-pag=
e block support")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/decompressor.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> index d4cee95af14c..2ec9b2bb628d 100644
> --- a/fs/erofs/decompressor.c
> +++ b/fs/erofs/decompressor.c
> @@ -323,7 +323,8 @@ static int z_erofs_transform_plain(struct z_erofs_dec=
ompress_req *rq,
>         unsigned int cur =3D 0, ni =3D 0, no, pi, po, insz, cnt;
>         u8 *kin;
>
> -       DBG_BUGON(rq->outputsize > rq->inputsize);
> +       if (rq->outputsize > rq->inputsize)
> +               return -EOPNOTSUPP;
>         if (rq->alg =3D=3D Z_EROFS_COMPRESSION_INTERLACED) {
>                 cur =3D bs - (rq->pageofs_out & (bs - 1));
>                 pi =3D (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MAS=
K;
> --
> 2.39.3
>
LGTM.
Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.
