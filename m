Return-Path: <linux-erofs+bounces-3740-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pm/ADbC8OmrvFQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3740-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 19:04:48 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03DEC6B8F36
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 19:04:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="U8mmWpU/";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3740-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3740-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4glBJ93mnlz2yQG;
	Wed, 24 Jun 2026 03:04:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782234281;
	cv=pass; b=JgCFC5K02JLeKV9VkrodOqnBT+jpQVqArKl4Sank47b+0miO177IECpgbGQH74i6pak1SWEPbq1SSE20bW4a5Xa5HI3wwxxz1RpQ4O4HInpYvazhgdBNum8p2N5/fyD/93fKZ/HB5Ux0+s/zGC7/+Hj7sMat8PuDcUMegjcx/nAdbr9DnmNwW1dVMicSp5SbxZf9Hrn0pCxAyIZom0VJLi90i2DG+i3Tn+QnUMDU20KRbpCOz/TLa4JZL7Ino3yVsd3sBVEaAUPVuh4Nsyz2TVuuJQm1AcLYlPZKBadOUi65jSPHHcJdovdHRYFTaw/V+yxrtrBVZxK/xECU2oB7Rw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782234281; c=relaxed/relaxed;
	bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIxCPVl+GDgivtCxlmYtYwq9QOD0tOhF6sQeIC8bmFObhRcgstzgoOU8QAfoO33aXSRJc8lziBqgFx7pGnjZQcuWUVMCju7hmFHdrr355WF+7SIbfu2JONj3DZOKS87t7U5QITKNEmDAzR7zLBTf9XXl0WJ18xMMxuiVImwaWM/KNr5iBI179FK8upDqeYZIA54MztWL55jqSUEZuPOuoWASw8nVPFVteP6nLnM2Nl2Fez688/Y10dnIg6Fv5P2F+KHZkl5lpILb0ZvXE102wQt5Nxou8oFdgPa5B+UhqhwD99dhr5cTEd0W9OFyXL3Q4jJ0JOGTZp2jqNvsIHdvUA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U8mmWpU/; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=joannelkoong@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4glBJ760p1z2xlV
	for <linux-erofs@lists.ozlabs.org>; Wed, 24 Jun 2026 03:04:39 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-4645995069bso98334f8f.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 10:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782234275; cv=none;
        d=google.com; s=arc-20240605;
        b=WRPiB5AXPkfr/cWOqsGwfwDcvhPYKrYv1tHMCCX/jjYh0ctgkRmiDuT6rKfL6gnQOg
         uMWdWNa3Miftjd53xirwl64P5XGA25g2s/WyvHfs3nwFVDJL+ZJsUYGjSfeyFfFEhbxR
         SQMc0GJ0PM69z+edDIjxkU+R0ubRYPD+kKDIqEJBOeNqvW6EP+8kaV2RSqFbZkT6Qpm2
         eNhTF4bSDQf/w6z0nJ2GUYZn4b8d9kfG7rAWAcXQQlYKJYgR1xAXMw6ZDz3k/IBc7Rt9
         Y5rnVxHsrbRSl6Q4ZjdN9PFW4pjnTdj7DaYa8ob4kHE7HCgQds6YzdykCQlq5zl2g6TM
         nEBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
        fh=GnKr24ESEZp9sMGubgDLcW8bgjf6hifrgwegnk8MEFk=;
        b=ict8GSXpZBQrWtCkPtyTSUBbP5UsBj2qMS1PUmCKHrIDsrmnwJRj3yhExumbDm/qno
         j6pIg6z19axf5hQ08Qqjh/Inxeq5naiKTpk1l6d7Wq+nYo/ZuU5FXrLtqL8kWl4Cz0u6
         VG0B0HzjjZ2Jn5+PnLkipJCk5Ad5byTA0wxlRrTV+lv9lACRTKqINodSZzoAi4CGNMtj
         EVNopXFiaNAeqinOT0UPynzFzOKX8FzokMN5/+t2e8ga0ENm6AqpBUrbcHV0M/621vHQ
         vV2j2iWml3W7rs+yALMEYdJGn84hQku2Ig7uFVGJdjvjKDVL3zJaDAka2Nm3gpZqvM3O
         rlRA==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782234275; x=1782839075; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
        b=U8mmWpU/EmhOmNjgmQwd/0zzYLhORoXAJHm36/xF+iCRuVyGuvoErYMsHK7+4prtIv
         VgFv/XcjsepXscDCHbNGFnUx66klYHxSuZGOdpzFBsEQRwLoQECjDWUlFXEijJ+oiaPF
         6nvEhkNXoXLJJJRYTuuhYbnMoYqxOMSBTlXo/uqeGmLB8GmnQ70ZFe+JUpuAiN1N0sA5
         YOXansQ9BPfkSHko2kWUCg8pAPN6jgpg80UjISKtvDEeE1DYMJpFJdPZrtf+mVQF61A4
         TomBrEodEGkjBt4+MaB3dme+3iuIBICOLhtaqAKYluARwKeE4ik0pkNtNtqcI6lfUhpN
         0cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782234275; x=1782839075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EchZhDXHLnIIeOQ/eg4q+Ls2B4SjaafDmxoTrWutOys=;
        b=iwc2HsjV99Qnz4LgUbozu6jS5kjFvNxNNirtWSom5gtnrLOkGGAYLfx5PVeCDxXEBo
         fxXCm/mUAI1b+mYvcb4mMSLx89kdgpJtfiNKLYtbYc9Q6PcKUH32YZpExMBXhz3d4xzd
         b8rTBBhw0D8Tg/NlbC/I9k1yWuRdLiJxJQ6blYU/yjclPunuCOJFj6H52CiYUZjOWA4z
         k8OV6QE0wyqfPqfrYgFygm0jG3NLJvtzR475kCp/9qOdkAV63UDrwn7G9W933VwJDcE7
         PLbSeACYSt42KoILEaszkEETw1Mqf/lf6iixeqRabx1tGX1jJ8nhtU1wnWBasz1gHyek
         BzWg==
X-Forwarded-Encrypted: i=1; AHgh+RraEhNid77pxSkmA77CZ6/0TvNbH/3HRxnro+IRETE4Gtw2e02wH/IwJTbFzOZL7yJitk17HOUmGrP3ZA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxlTWvzxMQJSdh005eRw9tJBdDF5f3NNOyvCIhC+eioMbdnpzQ4
	Yfqsm0Xbo/1ePQRhWT/pgy5q6uxP5OtGhdlw37EeQ+JOt/I0oE/pBgB0tcSqIYwE7gjZ5iZGCrF
	td+oBDiyw4N2dXu3k2au4YxeQk90WGzE=
X-Gm-Gg: AfdE7cl9FXdvPbet/8XsJVPXEICxywmPFcxiUBeIfLU//f9vzn1pRKTmmGrBaVdhi6Q
	U0eJQSRRgNdwSIrmsyBCnxpAldcVwbx7a0MThUfitA/+X24Ly2+IM2foGZmspLwdlMZ6rRBKyTg
	Zas+L0we/0NM10wLjY0u2vk4X8WHcnuWsr4/oCEcjYvD2NFhDx7fqbkmOQvdbNPTcvB3D3aRu5A
	vurKRGN1j5CJtgQp/Aae1uLOqyDgFO4n46Wy6Z26lhmiiddynn09ilKJOek9Xzx8mcZK+QfqTHV
	r7ZsxbhvRXyJWs1cJPhbetEp0YEVv20/wpoa3HNjWgzKrOI7D68n
X-Received: by 2002:a05:6000:46c4:b0:464:5df5:332a with SMTP id
 ffacd0b85a97d-46add1841f7mr4198572f8f.34.1782234274518; Tue, 23 Jun 2026
 10:04:34 -0700 (PDT)
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
References: <20260623135208.1812933-1-hch@lst.de> <20260623135208.1812933-2-hch@lst.de>
In-Reply-To: <20260623135208.1812933-2-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 23 Jun 2026 10:04:22 -0700
X-Gm-Features: AVVi8Cdq1cSEiVKuIT7rCtOjoNPEfhV6BkfHSOO37MXbTaAKd3fDSsQ7oc8pKTc
Message-ID: <CAJnrk1bq7pJEwwDuimp6GzCfdhrjhzs=MFAdRLOAdkJWmeSg7w@mail.gmail.com>
Subject: Re: [PATCH 1/2] iomap: consolidate bio submission
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3740-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lst.de:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03DEC6B8F36

On Tue, Jun 23, 2026 at 6:52=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Add a iomap_bio_submit_read_endio helper factored out of
> iomap_bio_submit_read to that all ->submit_read implementations for
> iomap_read_ops that use iomap_bio_read_folio_range can shared the
> logic.
>
> Right now that logic is mostly trivial, but already has a bug for XFS
> because the XFS version is too trivial:  file system integrity validation
> needs a workqueue context and thus can't happen from the default iomap
> bi_end_io I/O handler.  Unfortunately the iomap refactoring just before
> fs integrity landed moved code around here and the call go misplaced,
> meaning it never got called.  The PI information still is verified by
> the block layer, but the offloading is less efficient (and the future
> userspace interface can't get at it).
>
> Fixes: 0b10a370529c ("iomap: support T10 protection information")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

