Return-Path: <linux-erofs+bounces-3770-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VuDRLzYaPmqA/wgAu9opvQ
	(envelope-from <linux-erofs+bounces-3770-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 08:20:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0FA6CA9BD
	for <lists+linux-erofs@lfdr.de>; Fri, 26 Jun 2026 08:20:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="WU/L1yfE";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3770-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3770-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmlsb2Zg1z2yZ6;
	Fri, 26 Jun 2026 16:20:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782454835;
	cv=none; b=lFlx+huhUoe3t3sD+gA9d3z6gZRZ2sDkMi3ISxm5u/zLutLIUtmwi4Q77u7qa/Ttvt15kSciQg6zP15Ujg2bjbcLkTaOkDVSADOaGI6lbQev8LM3z7XbJokqKC2yWUupzasuJMrmHnZGTuqmJa8cYEJeb8JTjUEheZqUpz8sPvnio9ECKeuCf6EUagYy7n04NL5qRuv8Idc1FuH8M/Pye8jslFsoDYiuwpjJ/MvLhDC3NGYsAei25NHM4M28VtRuXJhJUnfL8ryM65BdXxbVRz2vnupucLS7EibA+uf2jY26nMbHbSdrNUY6wLuWqjc2Yj1lhGXsBcBZLejLMzEMFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782454835; c=relaxed/relaxed;
	bh=oXt3TI3KYVr+qcWdZITB8qJGMGwNWpZ94QcTDSJRm/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYVmyLUdnOQJ2PS51sPEpDatbrcvufpbu+9IMPUIbfBeyjAd+Lnq+tMldJTap/0Z0K7LXXYiQPYlBswPjFoFNZt7VeDUC4Jhx2kKjiJqC94O6J6tQ3n1Su2cJaDJ2whRv4OrwYxvJA/mPpUOnsQeb3wLKzyM+7zOPocHCS/Z7je0Cgs6KHg+1TPeb9YBXftLVi9K9GXg3Od50e7luDt6zgS4q0fcFZzeaXRJBH9vEgJ3B10w/c0OW+SJGql4TPmamspEJyLYe0R57Y+B9Kc59ToNndP3WPY9RAocjo5Bouo8VfSSxtjc4nB5jhzqK6+m8wtsLdtIRyMwIlw7yhWPOA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WU/L1yfE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=djwong@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4gmlsZ3wkwz2yYf
	for <linux-erofs@lists.ozlabs.org>; Fri, 26 Jun 2026 16:20:34 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id E2211403EB;
	Fri, 26 Jun 2026 06:20:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B55691F000E9;
	Fri, 26 Jun 2026 06:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782454831;
	bh=oXt3TI3KYVr+qcWdZITB8qJGMGwNWpZ94QcTDSJRm/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WU/L1yfEC2pGmaOfTfMjPKOjwaMy0wyqdhnFLjCOILvjO2REFqtZVx96g76tlKyUe
	 YcEVbk80irMUnaISGeH+dezCvaCemGir7VhLVow6Wq8lTBAeQiOq9/62OGD+8upClT
	 tlNeTpLiRSS5oxeCR/AnFOw0Ymd4DcP898QGin6SjmjjQUk6KUiyRydTSUqDw0Jf7S
	 JMVYe8xMPkJFaxtJ5xdEkA6oy3hB59HQfI2xBlGv+Pg4NwqBhOZ33N8zX1c1d3TiZ+
	 uMOMt8d3gN3nuMZBCvKoV69Knv8A9LV18xmyXIsSCdYBUUoqyD0osWt98ZI9jGevfj
	 4klA4fkf4VUpg==
Date: Thu, 25 Jun 2026 23:20:31 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Joanne Koong <joannelkoong@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Kelu Ye <yekelu1@huawei.com>, Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: submit read bio after each extent
Message-ID: <20260626062031.GO6078@frogsfrogsfrogs>
References: <20260625120803.2462291-1-hch@lst.de>
 <20260625120803.2462291-3-hch@lst.de>
 <20260625174758.GE6078@frogsfrogsfrogs>
 <CAJnrk1YFeirQ4g7qcVsda-8qPLeAtoiyW6ZBuJb2qDsGpxi-tg@mail.gmail.com>
 <20260626043319.GC8078@lst.de>
 <20260626061637.GA10337@lst.de>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626061637.GA10337@lst.de>
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:joannelkoong@gmail.com,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-3770-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,huawei.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,frogsfrogsfrogs:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB0FA6CA9BD

On Fri, Jun 26, 2026 at 08:16:37AM +0200, Christoph Hellwig wrote:
> On Fri, Jun 26, 2026 at 06:33:19AM +0200, Christoph Hellwig wrote:
> > On Thu, Jun 25, 2026 at 11:32:40AM -0700, Joanne Koong wrote:
> > > Yes, that works. I think that's a good idea. fuse only needs
> > > submit_read logic for readahead. The change would just be:
> > 
> > A nice, I'll fold that in.
> 
> Btw, can I get a signoff from you for this?  It looks like splitting
> this into a separate patch actually works better.  If you have a
> preferred commit log I'd take that as well instead of mine.
> 
> This is what I'm currently testing:
> 
> https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/iomap-read-submit-bio

For both of the patches at the end of the branch,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D


