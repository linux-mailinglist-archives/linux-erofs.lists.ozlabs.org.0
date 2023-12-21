Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 348FD81B9E4
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Dec 2023 15:55:02 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Od3XnYrF;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Swtkq61mgz3cDy
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Dec 2023 01:54:59 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Od3XnYrF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::e34; helo=mail-vs1-xe34.google.com; envelope-from=konishi.ryusuke@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Swtkl3Rc4z30gC
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Dec 2023 01:54:53 +1100 (AEDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-466cf6fab0aso149416137.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 21 Dec 2023 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703170487; x=1703775287; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pURYtu0NLCnQlpjaLQBb3A9CXAcN65Ivjf7L8viYZIQ=;
        b=Od3XnYrFF1WwR3Hu+JAUDU7UYQidIO+LyPjtRnkZ945N6i8sqJ7gNMy1PdyVrQMkwB
         KBGshhSl4xeJWY4JBUAn4l0TRqui2JT2nxPUAuZ2F6U4DrBiox5AlcAfQlz8bu6wJk9s
         FtusV5DSn1fnRywueIqsLeWhBmBi21AFRxTuCHp1r/2zPRW9h4tp7RuhTwhe0jWGznxj
         f3ybeOeHfiOdg1rCE2v10A7RTxajPhqRyQmYghvDmtRdJV6J93bdFfBj8OI1oMHChxyB
         Byvr5c+xv9jeJcvQ9Zj2PoHdiSuqXqnn4XBMKqbtlhkbq1cM7vexcyQ220BSRoJJgBoN
         pTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703170487; x=1703775287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pURYtu0NLCnQlpjaLQBb3A9CXAcN65Ivjf7L8viYZIQ=;
        b=CdoDqHBneaxqIjn0dIK/JIVyYjFk8bumRYeEksWC+sqU1ZDjZYZ9sBlYEqIEy5XHGx
         /oCmVtpvvEXO2TLt8eOt58aeE+7oQT7HuUVgz2SYDr2QRj8iUkPauzPbr0MRI+UfPoMb
         sDR6r8+hkQ2stQwYW1TB7yYYzNt7prfqAYdAOwPu1bzjqLhSB3ignCFw49P1tXMPeFI+
         wHocGAHj3raSubQfC7ljshcQ9pgogIoOf1EnZib6kvQTe3boJnLQ5JwdB9lO+drQNlnH
         bRPBpXMUQy8/KDfAed/fCZtWVf+oxLJ6zdIKZXdYgStj7Vbj20BjmO2v3M4qHYu2DWM8
         IsNQ==
X-Gm-Message-State: AOJu0YwzscQFbeMJS6kWI/DltM2KrXWWIDg5fjeSZI0lOwVqBmBWf/0s
	l1vg7F0O6uPZJLrlcmKpNBfMinZ8aov03vWmZZA=
X-Google-Smtp-Source: AGHT+IFN1NuYgs8WiPh35+AiECRKwSlqz0ZEDe3FqBLZ5rzeC9cKopqWDVql1xxie4BTiSGNKZ2Qkn8RU8vM8AW8lKI=
X-Received: by 2002:a05:6102:2c19:b0:466:a0dd:4b2 with SMTP id
 ie25-20020a0561022c1900b00466a0dd04b2mr1276429vsb.51.1703170487175; Thu, 21
 Dec 2023 06:54:47 -0800 (PST)
MIME-Version: 1.0
References: <20231221085712.1766333-1-yukuai1@huaweicloud.com> <20231221085839.1768763-1-yukuai1@huaweicloud.com>
In-Reply-To: <20231221085839.1768763-1-yukuai1@huaweicloud.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 21 Dec 2023 23:54:30 +0900
Message-ID: <CAKFNMo=TuhzyEs_NEOdYgJz+UVizU6Ojx4ZKXowDaux3kKddUQ@mail.gmail.com>
Subject: Re: [PATCH RFC v3 for-6.8/block 12/17] nilfs2: use bdev api in nilfs_attach_log_writer()
To: Yu Kuai <yukuai1@huaweicloud.com>
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
Cc: hoeppner@linux.ibm.com, vigneshr@ti.com, yi.zhang@huawei.com, clm@fb.com, adilger.kernel@dilger.ca, miquel.raynal@bootlin.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org, linux-nilfs@vger.kernel.org, linux-scsi@vger.kernel.org, richard@nod.at, willy@infradead.org, linux-bcachefs@vger.kernel.org, xen-devel@lists.xenproject.org, linux-ext4@vger.kernel.org, jejb@linux.ibm.com, p.raghav@samsung.com, gor@linux.ibm.com, hca@linux.ibm.com, joern@lazybastard.org, josef@toxicpanda.com, colyli@suse.de, linux-block@vger.kernel.org, linux-bcache@vger.kernel.org, viro@zeniv.linux.org.uk, yukuai3@huawei.com, dsterba@suse.com, axboe@kernel.dk, brauner@kernel.org, tytso@mit.edu, martin.petersen@oracle.com, nico@fluxnic.net, yangerkun@huawei.com, linux-kernel@vger.kernel.org, kent.overstreet@gmail.com, hare@suse.de, jack@suse.com, linux-fsdevel@vger.kernel.org, linux-mtd@lists.infradead.org, akpm@linux-foundation.org, roger.pau@citrix.com, linux-erofs@lists.ozlabs.org, linux-btrfs@vger.ke
 rnel.org, sth@linux.ibm.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Dec 21, 2023 at 6:00=E2=80=AFPM Yu Kuai wrote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Avoid to access bd_inode directly, prepare to remove bd_inode from
> block_device.
>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  fs/nilfs2/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 55e31cc903d1..a1130e384937 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2823,7 +2823,7 @@ int nilfs_attach_log_writer(struct super_block *sb,=
 struct nilfs_root *root)
>         if (!nilfs->ns_writer)
>                 return -ENOMEM;
>
> -       inode_attach_wb(nilfs->ns_bdev->bd_inode, NULL);
> +       bdev_attach_wb(nilfs->ns_bdev);
>
>         err =3D nilfs_segctor_start_thread(nilfs->ns_writer);
>         if (unlikely(err))
> --
> 2.39.2
>

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
