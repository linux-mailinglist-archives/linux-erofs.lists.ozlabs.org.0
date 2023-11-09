Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A347E7408
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 22:53:00 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7njR+5V;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ak1JROyP;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRG0V5xP9z3bv3
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 08:52:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I7njR+5V;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ak1JROyP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRG0R2bzHz2xFk
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 08:52:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ooj0huzmXViB3IPA+8ZsWf/tvcP9vcxEUy2C65Cs8hg=;
	b=I7njR+5VaSGAzjJKJG/tRQdCd+Vy6IlZzOaXnHS7TcA/N14Y6l0Iw/0U/5TrlowBXZcyDX
	tvh0l4sxjL2sCegLJ4ikGAf20wlxJnLKwTmbf++ZFY4eCbfT12TvBe4eIcSvQGZFFpBel9
	ntXSxo/riwSxOgiQCX/86jmq0fGyP1k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ooj0huzmXViB3IPA+8ZsWf/tvcP9vcxEUy2C65Cs8hg=;
	b=ak1JROyPuGl7SoLUOBOoUOyo4OpTBUH7khnv2mOE3wTU/K1fMr8w3/EVwWyvjc1LCq+Vr1
	CjiqDURlYWNYJlejNlxiA29YD11+A9B+oWm6aWhEK+17A480y44s1VlC1/DhOdgJaipn95
	cya7Eaa0OvdDDdit+aycfjURd22wwOo=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-IuS6_GxhPhKvKzJvBy_yUQ-1; Thu, 09 Nov 2023 16:52:50 -0500
X-MC-Unique: IuS6_GxhPhKvKzJvBy_yUQ-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc1397321fso13415985ad.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Nov 2023 13:52:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566769; x=1700171569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ooj0huzmXViB3IPA+8ZsWf/tvcP9vcxEUy2C65Cs8hg=;
        b=UT9uYShv8xSdQSfGQnJZqBpkWwDJpkH4VZfosqNryrBMwAKuGBMLnXPMCAsytld0kM
         poKbRs3MPPYTMHXq4bimcJKwMi89aDRyoe1dQBjANMCLmmUz8mOy9n3sdh5l+4iFPqtJ
         d5+o9QDjltiMqsPcwaP/L518A4qc6jXeXsT4Fv+mDKA3f8dxgpmTEzgWkNs7feZl0ZYK
         IH3mFQNGzJS8tqD+3rp5o+NauQQ4eS7D9ggYVEuE1AnATz3v9y95N4uLFud667g4T0X7
         Tk7ovb8dvYBLcOkPwyDNhl0ur0c4BRR2ALreuHMzzsQxfGo2eqvoLjNTkEpIM3MFTsh9
         NTLQ==
X-Gm-Message-State: AOJu0YzTRsL933kwmQGlmwS3MpLq2Ifezefh9LcYn4ZZtJUFd1S3NNA8
	9hcNyF1+O6Bl08KKHLP0OwKpA1IZD1nLmb8C385qxosIGvUvAolxqTDTVV2lOH1dVasM3GHq5ch
	mS+CoHMzdQVI+bPllgG3eQvOdPIzbFigSrWwMaacb
X-Received: by 2002:a17:902:d2cf:b0:1cc:42b1:934b with SMTP id n15-20020a170902d2cf00b001cc42b1934bmr6973371plc.18.1699566769068;
        Thu, 09 Nov 2023 13:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE2w5kiS+35bQf1w6M0QjE1cVW4EjHgMurxmQucKCpYNIosx46laiJfbx3QyQx2atURPUqY64X628qUAuI/IrU=
X-Received: by 2002:a17:902:d2cf:b0:1cc:42b1:934b with SMTP id
 n15-20020a170902d2cf00b001cc42b1934bmr6973354plc.18.1699566768767; Thu, 09
 Nov 2023 13:52:48 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-4-willy@infradead.org>
In-Reply-To: <20231107212643.3490372-4-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 9 Nov 2023 22:52:37 +0100
Message-ID: <CAHc6FU6-a5Xf1Zesj0Y9udXLaxg5nnK5t9GPxA_b5PHNU8brvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gfs2: Convert stuffed_readpage() to stuffed_read_folio()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Use folio_fill_tail() to implement the unstuffing and folio_end_read()
> to simultaneously mark the folio uptodate and unlock it.  Unifies a
> couple of code paths.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/gfs2/aops.c | 37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
>
> diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> index 9611bfceda4b..ba8742dc91f8 100644
> --- a/fs/gfs2/aops.c
> +++ b/fs/gfs2/aops.c
> @@ -403,18 +403,18 @@ static int gfs2_jdata_writepages(struct address_spa=
ce *mapping,
>  }
>
>  /**
> - * stuffed_readpage - Fill in a Linux folio with stuffed file data
> + * stuffed_read_folio - Fill in a Linux folio with stuffed file data
>   * @ip: the inode
>   * @folio: the folio
>   *
>   * Returns: errno
>   */
> -static int stuffed_readpage(struct gfs2_inode *ip, struct folio *folio)
> +static int stuffed_read_folio(struct gfs2_inode *ip, struct folio *folio=
)
>  {
> -       struct buffer_head *dibh;
> -       size_t i_size =3D i_size_read(&ip->i_inode);
> -       void *data;
> -       int error;
> +       struct buffer_head *dibh =3D NULL;
> +       size_t dsize =3D i_size_read(&ip->i_inode);
> +       void *from =3D NULL;
> +       int error =3D 0;
>
>         /*
>          * Due to the order of unstuffing files and ->fault(), we can be
> @@ -422,22 +422,20 @@ static int stuffed_readpage(struct gfs2_inode *ip, =
struct folio *folio)
>          * so we need to supply one here. It doesn't happen often.
>          */
>         if (unlikely(folio->index)) {
> -               folio_zero_range(folio, 0, folio_size(folio));
> -               folio_mark_uptodate(folio);
> -               return 0;
> +               dsize =3D 0;
> +       } else {
> +               error =3D gfs2_meta_inode_buffer(ip, &dibh);
> +               if (error)
> +                       goto out;
> +               from =3D dibh->b_data + sizeof(struct gfs2_dinode);
>         }
>
> -       error =3D gfs2_meta_inode_buffer(ip, &dibh);
> -       if (error)
> -               return error;
> -
> -       data =3D dibh->b_data + sizeof(struct gfs2_dinode);
> -       memcpy_to_folio(folio, 0, data, i_size);
> -       folio_zero_range(folio, i_size, folio_size(folio) - i_size);
> +       folio_fill_tail(folio, 0, from, dsize);
>         brelse(dibh);
> -       folio_mark_uptodate(folio);
> +out:
> +       folio_end_read(folio, error =3D=3D 0);
>
> -       return 0;
> +       return error;
>  }
>
>  /**
> @@ -456,8 +454,7 @@ static int gfs2_read_folio(struct file *file, struct =
folio *folio)
>             (i_blocksize(inode) =3D=3D PAGE_SIZE && !folio_buffers(folio)=
)) {
>                 error =3D iomap_read_folio(folio, &gfs2_iomap_ops);
>         } else if (gfs2_is_stuffed(ip)) {
> -               error =3D stuffed_readpage(ip, folio);
> -               folio_unlock(folio);
> +               error =3D stuffed_read_folio(ip, folio);
>         } else {
>                 error =3D mpage_read_folio(folio, gfs2_block_map);
>         }
> --
> 2.42.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

