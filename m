Return-Path: <linux-erofs+bounces-3744-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AuLCIqIdO2r2QwgAu9opvQ
	(envelope-from <linux-erofs+bounces-3744-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 01:58:26 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A51696BAA3E
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Jun 2026 01:58:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Jx5jXtLO;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3744-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3744-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glMTW3P31z2yY1;
	Wed, 24 Jun 2026 09:58:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782259103;
	cv=none; b=J3q1XfxkF8JonS4/d/Sanj4R4w7/Som/jpW3uQOQmgXzQ4+MyNbvqni4G4znEKMZWjv5Vp/UkXj247lN/v3fRQvRRjl/ENEtAkmb5xj/oEHqFNUkbuV6IcT5p3Nf4xZ4PGp6UlLjr8xqyuQSZH9iVyYpTR1aA7ypSgj8u0hMZOb3WLLiY5eRYJBN1USUL18FddTrBUtgBZxNmsDYBYYo369a6uYu1nxyNUvHHHnoPo+M3OzZVebyQMAk28evJDG5Y1zh4Bwh04aS2Ru4I7aC/ULLrWVPQyrRv499cbEbyOW2+Jn2sASxgbn4SQQAeiZXSfKf3AQMj6ts+WVlx9A+0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782259103; c=relaxed/relaxed;
	bh=O5yRpEyknAxQBuWx/gb9cR/auuwDKfX3rH28YfAhJjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aFoZ/en9RA1J7+T2TJU7ETLEEtm+GAZCMyhA1VZQhGDHlExU0FNWa+0R7HS73tjcA5zJLV5n8nZOlVWc4C415ONWw8rIspNyrvHXTJyTJ319+A67CXvjw9FcGuS7aztcjKYZnqV8W25A67jpiDnqQifoubAhPgGvYHuXFvvuY1AYkUeHoBeA7Dl/RSf7V0IAbxhHgp23Q7g9UvuP3o5uHXGfmVlVlQTSiL40xPO4VXbFbvu1cYqCYVN2AB/qE/fFw2m3zTcv9yU+0FVX4AKKUsCjoCe4puvmsX9qBl97IV7qh/lWwi3lG5H9D5JII9zRUKmC404uTY5V7uKI9E3oew==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jx5jXtLO; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=linkinjeon@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glMTV4W0Qz2xJT
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 09:58:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id E3DFE60138
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 23:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7691F00ACA
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 23:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782259099;
	bh=O5yRpEyknAxQBuWx/gb9cR/auuwDKfX3rH28YfAhJjA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Jx5jXtLO6qD0eU852kbyhOE7cZg+TuQFr1lFPhjF0se8P1kGZJiypZ2BNLzLIAxC+
	 ePk7KO0AzySggx0z7lemEvppffSjKFrQA3d0sqsYu6qeOKKNd//o6wc1ciWaoNR2tP
	 AQIjTOgThLXS//DkR+tJ3Zf05BozViiHqEq5wVM4TB/8NMF01N+zQCQRGJQKjFHrqL
	 9rhENPAvHOlArt8b0KZYpXNw2D5Ph4nxYhjxMsuD1fN49GwqptBWDVMkef+8c65x/A
	 JxBsfKb27BVKFsQ/H7A4d84hZWAcR+f1lZ6W6Ce8RvI3JabFlb64HX8FXjkQjawBl7
	 IrDVkdLVshccw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so68248466b.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 16:58:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ97FKiCnp98s/fNpkTllMz6nDaUNr9rzSmj1nOpkLcJPbkc9v6GlW7RinGngy60uvuM35aGUR6WfHs3tQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzIh7d7kHgE9AXb6JrRC9ZCjE+HV9sQOKuUz9rNP9Qp47G9p8Tf
	UAvM15Wf0agNhRgxYR8cOYfhpXS/8Vl6jiVAik0CcoIuoSR4TWb08nZmOmmD1nxGHXzgkaRcdQN
	cSI1pSe9vnrUuAn7GurXnBCskxTF7mE0=
X-Received: by 2002:a17:907:74b:b0:bee:c13f:7ebd with SMTP id
 a640c23a62f3a-c1030fa35a0mr276264466b.16.1782259098316; Tue, 23 Jun 2026
 16:58:18 -0700 (PDT)
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
References: <20260623135208.1812933-1-hch@lst.de> <20260623135208.1812933-3-hch@lst.de>
In-Reply-To: <20260623135208.1812933-3-hch@lst.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 24 Jun 2026 08:58:06 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_8W=S8WmK5J7dnm-j0QycJHAdPOdeuSg6EbwSYgHg0WQ@mail.gmail.com>
X-Gm-Features: AVVi8CeHD55lDgJcabqaov8VHEMJrqVQlqyVWrCatN-0pn2R5gDSUfP8EbUYUjs
Message-ID: <CAKYAXd_8W=S8WmK5J7dnm-j0QycJHAdPOdeuSg6EbwSYgHg0WQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3744-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lst.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A51696BAA3E

On Tue, Jun 23, 2026 at 10:52=E2=80=AFPM Christoph Hellwig <hch@lst.de> wro=
te:
>
> Currently the iomap buffered read path tries to build up read context
> (i.e. bios for the typical block based case) over multiple iomaps as
> long as the sector matches.  This does not take into account files
> that can map to multiple different devices.  While this could be fixed
> by a bdev check in iomap_bio_read_folio_range, the building up of I/O
> over iomaps actually was a problem for the not yet merged ext2 iomap
> port, as that does want to send out I/O at the end of an indirect
> block mapped range.
>
> So instead of adding more checks move over to a model where a bio only
> spans a single iomap.  Change ->submit_read to be called after each
> iteration, and pass a force argument to indicate that the bio must
> be submitted set on the last iteration.  Switch the bio based users
> to always submit, while keeping the single submit for fuse.
>
> Fixes: dfeab2e95a75 ("erofs: add multiple device support")
> Reported-by: Kelu Ye <yekelu1@huawei.com>
> Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
for ntfs, exfat part.
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

