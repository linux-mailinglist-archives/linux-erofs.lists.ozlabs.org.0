Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F236A124D3
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 14:35:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY6Sb00Tnz3bh2
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Jan 2025 00:35:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736948125;
	cv=none; b=Si5lYpii+DHFtkN5CxMsMco7vWclPjne1JAlUUlqtE1UHEkCa5R+Pwn9CmBoDzs2v39gRCmaa9UGHe/AekX4w2mEt0Bly/k/fiMC/LjJYVcDwjoT8PGb/EUwkw8c5zIoXCHDSNFT4m9/P3DgOBlsI7J5aX/ya+v+F2poHt3MLjRP49ZNOTEqfmpbwNTVmgfWgpGDwxCbVpKh5ZFoY4ynBuY7viLSQKhaQcltWO1VOxU4be52ZssDVY4pIPodhxtDWbkjKfvHR6j/4NBSo/+wFJqtdUp6YFIAzl8a19b7cuEJ6ICGY4hI2ZWPQoMiinqeQVuncGRt/6FQVvCcfFOoWw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736948125; c=relaxed/relaxed;
	bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsLkb4b0pgAnubYDjkupr08oiNDqyZe5TA8SIUjM+SMyJmE/3NCT5xOVI05Ro+sX5XCAAdJbHycQ4QkhrxSPPdmCOeq4EMKKQ6M7bqbdDuK+DA6036NmBF1XEnuyIgt8XOM6zFqMHUXDESmwVyam1FdvSHpucBkKBDijPfiTKSnSkWvVo/s4zeYiALVE0gUS5dc7sY8j9buinCF82DZdz8P8EVKZ9XHiSRBNdYU6dw0eaSW4Gyeqp8FgSTUTJYp5C+JnyVtqTLatL2bb3n39Ho3xjseWpiZ2yFrI2E3qaeY2FAcw9fDYKwQeqAWxkX7aXPXTzsRxPdO2J17STl7TTQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9puDrdS; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGIW7+4N; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I9puDrdS;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hGIW7+4N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY6SX6PFRz305Y
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Jan 2025 00:35:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736948119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
	b=I9puDrdSrxgg/fyFpPxfIVE21nzbPiysmdSSCSZdnSNpZhS5tFfI6avb74lCckMFDGfJ1G
	f3whTMHMysRdOdRdhp2v3Y3+k6BncCGZZEpz86I1CueZVoYwLOKs3OeSYKj8Z0AXAMXr8u
	pbqQIBARnbiHiY3RMofohR8rDK2tyXc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736948120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
	b=hGIW7+4NdA/7bz4IUSBBZYmrLQcmcYgReuTfj2ilzjCf5u4RE44OUogxNS4MFxQAXAx/AM
	LcJ+B/+5DZFENbSuP5fF3V3HHtT4fgt7jcgWST5AfShxSkQGjc5u2LoQHDFiQVc4UGVEbp
	5cZvR7ZHSoj+UVbTzs/JiU2F+X9y5Yg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Lvia7cxAO8-uzZEGMitnag-1; Wed, 15 Jan 2025 08:35:16 -0500
X-MC-Unique: Lvia7cxAO8-uzZEGMitnag-1
X-Mimecast-MFC-AGG-ID: Lvia7cxAO8-uzZEGMitnag
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-216430a88b0so133035555ad.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 05:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948115; x=1737552915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EHMPieLiEBxInJQ6B0H0UcMOipXZzYAKvCo+eqZFwfU=;
        b=DPJKwZgZN52FHiyl5xfC1oQ9cgJ0CvC/Tr7Gi1gW7brCGlE4RrUb8OYGNvxI67ji6u
         QuxRVLkgNCXSF0+WjD7NRIar/9NMQ9QR4zsIQ2F71FeS1OTzuiogN4yNuGJNNqdOD31a
         2kJR2PK4vpqn4BJTx10H/WJNSfKNpsSVMJBUueAwu+qZIAvEiNAqMVv1l1GRsYyoP/fE
         ufY6mS8xkxlPhoYMY65QsI+DCOC9aUHiPkyiLmlDemmhd4AWPIdlv6KPuDlFjBMBTwjH
         aFaMwR32gl4+nh8e9FylUQ7Vqvxnm5UsKg7Od5Oc6dNQw3IW+ozz2stROMgoq0TFdk0i
         D8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUmN/wKJbAJJMeLBkp0p061Q/P1+X5bG+Bo6iMuU706LoDrNxVZJ39qvXbUBoCBTnrb8E1LtLDTnh1HIA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yzup90btF8aHj1D+Gea3ZbyRLHQT9viSfKQkNQFyvPmfySoo3sQ
	EvzIe3w84RB2ni2HHLrvqqKtX4SP/fqIz4EVgaZ8eqcWh+RKV62504KGdw9PAqJOgjhczX2Uruc
	3sQCzFiPxq53YBwEAJzyhJLh3Tb/6U1Njb7hT+U1NRlkVD2HzkhMrnorZC7EFIy4SAoy1Fu1dpv
	3LA5L5BeJA6v7pNeeQMZTa98QsOnz91n9EA3Tx
X-Gm-Gg: ASbGncutTB3GQnlqETU3pBqPxkc4jG08FfKRCo5q+39vXidkvwJVJmrbdlTqx3zcJKm
	sZDyVzIzQUq/FMBsO9RjsuN2vEM9DHBWcfMSY
X-Received: by 2002:a17:902:e548:b0:216:30f9:93d4 with SMTP id d9443c01a7336-21a83f3706amr390737015ad.8.1736948115383;
        Wed, 15 Jan 2025 05:35:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4uFvmvU7kjxrhOu/tKhko5zsquSsHGxstfr2wyI0IDTeSXaYwdT9BokTtob0w3UYMJQDUxkbCE6bgd9fA2Go=
X-Received: by 2002:a17:902:e548:b0:216:30f9:93d4 with SMTP id
 d9443c01a7336-21a83f3706amr390736605ad.8.1736948115070; Wed, 15 Jan 2025
 05:35:15 -0800 (PST)
MIME-Version: 1.0
References: <20250115094702.504610-1-hch@lst.de> <20250115094702.504610-9-hch@lst.de>
In-Reply-To: <20250115094702.504610-9-hch@lst.de>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Wed, 15 Jan 2025 14:35:03 +0100
X-Gm-Features: AbW1kvauTrK99eaFRcWITgoY8moGa8lcIr8CyUarTCKymnr2mM79lYdYrNNq1Dk
Message-ID: <CAHc6FU58eBO0i8er5+gK--eAMVHULCzHPnJ9H5oN12fr=AAnbg@mail.gmail.com>
Subject: Re: [PATCH 8/8] gfs2: use lockref_init for qd_lockref
To: Christoph Hellwig <hch@lst.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xmDvWVnxKpTMCIkq1bwI9xWl397H9Dl6QEoiDYCyXIo_1736948115
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jan 15, 2025 at 10:56=E2=80=AFAM Christoph Hellwig <hch@lst.de> wro=
te:
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/gfs2/quota.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
> index 72b48f6f5561..58bc5013ca49 100644
> --- a/fs/gfs2/quota.c
> +++ b/fs/gfs2/quota.c
> @@ -236,8 +236,7 @@ static struct gfs2_quota_data *qd_alloc(unsigned hash=
, struct gfs2_sbd *sdp, str
>                 return NULL;
>
>         qd->qd_sbd =3D sdp;
> -       qd->qd_lockref.count =3D 0;
> -       spin_lock_init(&qd->qd_lockref.lock);
> +       lockref_init(&qd->qd_lockref, 0);

Hmm, initializing count to 0 seems to be the odd case and it's fairly
simple to change gfs2 to work with an initial value of 1. I wonder if
lockref_init() should really have a count argument.

>         qd->qd_id =3D qid;
>         qd->qd_slot =3D -1;
>         INIT_LIST_HEAD(&qd->qd_lru);
> --
> 2.45.2

Thanks,
Andreas

