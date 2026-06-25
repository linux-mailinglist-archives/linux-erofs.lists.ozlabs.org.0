Return-Path: <linux-erofs+bounces-3762-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X9FXOmF0PWpe3QgAu9opvQ
	(envelope-from <linux-erofs+bounces-3762-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 20:33:05 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EAA6C838C
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 20:33:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=J48C2kpy;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3762-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3762-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmS991rsyz2y8p;
	Fri, 26 Jun 2026 04:33:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782412381;
	cv=pass; b=mRnnKh/eMGr+WkJG7XBHipvsNzSXRjFCe58Inlnjh4vLOfaX9v6ZCKSNGRKa/9g/suwcONVxSCgS0CaDviRFxgxsmxul1ApMs9f91FnR1xAOOOwtiY+7brhXh/zpsp+4aMVazaRVCSXvBNeUoPGJ8YNzm6MQORTLq6n4R++DUtYeWzu14icS/h02ex/LNsK2WqMzxr+nid5bcdGCkYcOg7qBt7YNrVLmvJpi/bdwgSynGsIRbpmsWrgDI6HSuv2yfjVSUIwrhqE1Y+mQX9/dCgB1uIjTlAd0owWoRSVQLEw/n051ra2oTTFkUJjaWxyXlX32N9A3Xn/a4dRzvZshnA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782412381; c=relaxed/relaxed;
	bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TdEXhtJxZ2V9abjwd6NQany99vfHnMyRxoUmzVwclqTXq6ITskKGyBxonn8GAGDdsG3vVAj+CjU5V3yAagAFocaFjdWQ3S1gRmWYH9hky3g77o7EL6t24UWygAg5Uf1jchoB2Iz1TB8uZ2dgmVRNjj4t7fQj2mtGJb0nAs+p0SVEuZJOmp1oPaNuMkrx1X3b+lo6oXGhEnIVoX+r2dmENi5tNDx87S4GdeeAdlFrpobkLyvrtZEdLZnEYeKJ2cqEb9EsMGVh/nHJF72TL5QuggsHywvoBb6p11aCD23RgDDZkhEBP354UGAw2QlJ78ZJ50xBjQ0JF5WxIidCLXdU7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J48C2kpy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::42a; helo=mail-wr1-x42a.google.com; envelope-from=joannelkoong@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmS963rHsz2xLm
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 04:32:57 +1000 (AEST)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-461edb387ddso45460f8f.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2026 11:32:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782412373; cv=none;
        d=google.com; s=arc-20260327;
        b=VjySK8SjmdDOLSpzjCqQHsxnUH6a/JGBZ65ZYw4WnPiDCT3FjqNX3G0gmAgssT73q1
         RwP+YeyU0XuFnrg874DpFEuzl67E6aHR5E1MN32fDxAthMMc6FpIcxe4vjfraKAdC0Rb
         rquOy7M5L6gfnLttou7GTIzHptlvLUC8lrl38gSaxP2iCc23AWRHbdARcJZLbqr84AOj
         uoL71Jy7nWC6dmWR2bchYUO07xb0S3T3AHz6vxl6uH7mpdp9zV/F68tNMy2RJb36X2+u
         tn/WI75xGfcTpLQicAmluWdv0gSIRU5BbpZ5/r7MvRJuoHz+Vnev5QpdNDi59HbC6G8U
         DbGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
        fh=6Fvu+sogPrHyQKMf/kev43hKnZlIGX9cGvtTcouDIME=;
        b=keRJuTW6iVcX3VQzJ5+dl9T1WccGjuDGtpQTQFQyMfRLdAd6U0mIVPrAlVRbb23z8V
         c2G/ovSHOLkeZ0MOgun7nBseOgeHOy1KtXYJMmrtPlPlocKnLW11UT6/gh6pg+0la0nJ
         tGq/7NzpZcTZWLzRqigIj2LjU3KwRpkGxX1i/VHxYn/Wg89SHJ101ii/Ja+0MwoTZXL8
         nSLij7V8KHCPNK+COeMcGsM6VFp29WkJgm+nwCjsSc36jgeIiDxEuTcy6fRHS7cqbT8j
         yYvagpNapKi1Y/RDOrycMpQe1UbX5s3/ecmXRvANsiwAB37d5ZdlQRQp0OET7dlG3P75
         3Z4Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782412373; x=1783017173; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
        b=J48C2kpy/4B9yFQ/qWVAnr9qnWLrJRhF6BHEuRdrW+X3GFBXZ9xpGnn6FpNwZAdo7X
         uQQVErUy0Fgro74vvSO0vG62T2aUQtZgHLVUkmqJye5DL6DHKiV8qtCur/KsQGXd7+i7
         5H+PyPwLedsPvevrp1sQARiQX9t2qQc6ZMQ4CAFjhhx7o7O9NUYy43aT/8yuzSWJoQ1P
         xJuLuH9UsAN4P48FFcr79RXcDgDPky1bgoBVEq47WAO6HyBE4n+OcOWnKJUZIZ7ky2T4
         2lIylxYDelvk440/mw1rAMhnLAzOdr5gw7pbugJ3OOuifcrP4c8bywCP+KwmPYnvHjQU
         1iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782412373; x=1783017173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g9V61tcEtmNSRd/wIPFD8Kzb7PIr8WM9gRz3AhdzXFA=;
        b=cZGlthym4K5NZtTkd3MlmO63uTOZdT11V/T6wtquLLC64GRzqcjQxi0MHWorRI9btH
         ZjPzXGr6iTHfkKX/I6nB2SJOglU9sNhcAZAXiMypXc3U5R63kGDJJLYML1jgz+d2uM79
         zObN6IeHEeb+rLeH7ltlA8D64UDU/PHi5reNLkPtBHRPsH4Dc1t8Dw1dG/wqYEj5B3Mw
         kyRMAPADICa0nHjn1xHtoD9i3m502HjhPae4F8vALAN+3NIUquo8hbIGfI21nyLkCAJ2
         n8Cpfsq1vpujxC4yGxAQAaitQpkco31JO6OHxj3WjLPZ0cUwImmMqJbsbujNerBrnsKV
         /a4w==
X-Forwarded-Encrypted: i=1; AHgh+Roj3Mj081ieSuK/IvlGa/YYaLpSQ5rbO4G1qfT3agKgkAatY+QeYL6ra2qNfcGLGRFrAs4aybWxQPhhWA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywz2bDlP9DUXJmMRmyO/g4EEKpWHhe2tYOegNz5XU1W1YBv6N+8
	1a62L7SeLWwC/mENoO1CgAH32YaohnJYVrJiVomWdrUQnvYSW00cy9PWhHMFB0QSZq4F3RCcvOu
	l/tWayig2O8G19ntKTb+yf2m6g4GIH8s=
X-Gm-Gg: AfdE7cmDK8aiuYaWWyuEJpF4NbmUMf8rlnMbxD46ZdotMRtIHvgEPKXxmC6BWGsz6Ya
	ZYhji9YqXW9td4Wy2Nq3DnwGBMYrXoYZh2Kb6zBlidq6WRRTl+d7Ix0BrhW0PkXYb3Ptd2QuIpZ
	Xenp/UGst/g80Nfbi4BnUWqY3il15sFycMaReLzkb5bnh4vxFCM/b+YehC/1a/wSvCDS9UUqr40
	uMLtKWzadxyNy/lDiv0XMNnjqAD/8dfNRH3NdibF9Vg03LTsIiG3NlFFrb0Ddyr+XeYEZLX7Pe8
	UtMLN5+7E6H40ZGed4uop0Djb7U6hecbml/hyVbHGvAat6LEjF/s
X-Received: by 2002:adf:e198:0:b0:469:3bd0:fa7d with SMTP id
 ffacd0b85a97d-46dc1e7d2aamr5538200f8f.41.1782412373179; Thu, 25 Jun 2026
 11:32:53 -0700 (PDT)
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
References: <20260625120803.2462291-1-hch@lst.de> <20260625120803.2462291-3-hch@lst.de>
 <20260625174758.GE6078@frogsfrogsfrogs>
In-Reply-To: <20260625174758.GE6078@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 11:32:40 -0700
X-Gm-Features: AVVi8Cft-saEfjqDMyKwAQ7hs3asCzTZsJFUliVou9sVBM1d6hPzz_2GUJ4y52Y
Message-ID: <CAJnrk1YFeirQ4g7qcVsda-8qPLeAtoiyW6ZBuJb2qDsGpxi-tg@mail.gmail.com>
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>, Kelu Ye <yekelu1@huawei.com>, 
	Yifan Zhao <zhaoyifan28@huawei.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Namjae Jeon <linkinjeon@kernel.org>, Sungjong Seo <sj1557.seo@samsung.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3762-lists,linux-erofs=lfdr.de];
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
	FREEMAIL_CC(0.00)[lst.de,kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9EAA6C838C

On Thu, Jun 25, 2026 at 10:47=E2=80=AFAM Darrick J. Wong <djwong@kernel.org=
> wrote:
>
> On Thu, Jun 25, 2026 at 02:07:57PM +0200, Christoph Hellwig wrote:
>
> > So instead of adding more checks move over to a model where a bio only
> > spans a single iomap.  Change ->submit_read to be called after each
> > iteration, and pass a force argument to indicate that the bio must
> > be submitted set on the last iteration.  Switch the bio based users
> > to always submit, while keeping the single submit for fuse.
>
> Is fuse the sole reason for the "force" parameter to exist?  I wonder if
> fuse could drop its submit_read function and call fuse_send_readpages
> after the iomap_read{ahead,folio} function returns?
>

Yes, that works. I think that's a good idea. fuse only needs
submit_read logic for readahead. The change would just be:

--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -953,19 +953,8 @@ static int
fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
        return ret;
 }

-static void fuse_iomap_submit_read(const struct iomap_iter *iter,
-               struct iomap_read_folio_ctx *ctx)
-{
-       struct fuse_fill_read_data *data =3D ctx->read_ctx;
-
-       if (data->ia)
-               fuse_send_readpages(data->ia, data->file, data->nr_bytes,
-                                   data->fc->async_read);
-}
-
 static const struct iomap_read_ops fuse_iomap_read_ops =3D {
        .read_folio_range =3D fuse_iomap_read_folio_range_async,
-       .submit_read =3D fuse_iomap_submit_read,
 };

 static int fuse_read_folio(struct file *file, struct folio *folio)
@@ -1089,6 +1078,9 @@ static void fuse_readahead(struct readahead_control *=
rac)
                return;

        iomap_readahead(&fuse_iomap_ops, &ctx, NULL);
+       if (data.ia)
+               fuse_send_readpages(data.ia, data.file, data.nr_bytes,
+                                   fc->async_read);
 }


If this fix needs to go into 7.2 though, maybe it makes sense to land
the v1 implementation [1] + the xfs integrity fix now and do the fuse
change later?

Thanks,
Joanne

[1] https://lore.kernel.org/linux-fsdevel/20260619050105.439956-2-hch@lst.d=
e/

