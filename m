Return-Path: <linux-erofs+bounces-3800-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q/88OAs9RmpFMgsAu9opvQ
	(envelope-from <linux-erofs+bounces-3800-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 12:27:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 795006F5E4E
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Jul 2026 12:27:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3800-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3800-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4grY3T3kp5z2xLk;
	Thu, 02 Jul 2026 20:27:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782988037;
	cv=none; b=CrfEjDx5G0VyH9twyyGiD74L5riE29ep4dePF4aV4TJxs6bNVTIn6BKRDciGHDDxZm01DHEhMYnTWt/GSmTOY7s4emIPviTzKPn9o6OXRrpPd5jQmTPXmx03dFa0t/g12xWzb3KYtEp9z/gtRHTW21FUawkqPcPgpEsYGTPcgTKka5RWk7el4G8rEsxbj+FxsEhQtMXXupHdi8k4YiqcLPHa3ycivJw0X0RaeTCTLVwNsq9Xmjzw7Olp7t5iCEGP9sRiNChks/2Q2qlfFlLtdwDMoBrbYvsB4pjvVp5t4ut+HUpQx6b4oUxOaFeh/HNuytXTnHi9X3NlcoB/5j+tNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782988037; c=relaxed/relaxed;
	bh=2QSpOHJ4tbguE1GPlnnA7Qo/MJflg19F6M7cmaJHNU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrXGqKSaGclTnNwgL8Tn1tixru3Fdrox6OcN1g39TxRn5k0X3QvC3Cxt+5gzW7enKU/MGo/M5m4LmeC8+qSQ26/j4+0ZORm9D8ZPpARWGlq2wLWAeCD/YnhwoFWgvmbiNm5X0rbup59HJjmoDuoHRKiMfzt1tVRSeBQP179nEgdzS42gstep0H4vDQ6pNKc+zeAlzSYXabd166UaHKx+rqlzkWFaeX3FNGXRYJkFIrxNq7XFBbwo3wapnvBChJUnosWTfaFmJHvi7OV1u6IlMHqSkkXBRzabnhLLyB3st5xjsMiK9Hf9ADmHjWdtK5s7WQDPHoaQMwsbnh1RE/IvGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de; receiver=lists.ozlabs.org) smtp.mailfrom=lst.de
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4grY3S06fXz2xJT
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Jul 2026 20:27:13 +1000 (AEST)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 35C9B68BEB; Thu,  2 Jul 2026 12:27:06 +0200 (CEST)
Date: Thu, 2 Jul 2026 12:27:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Kelu Ye <yekelu1@huawei.com>, Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iomap: consolidate bio submission
Message-ID: <20260702102705.GB6252@lst.de>
References: <20260629121750.3392300-2-hch@lst.de> <20260701-davon-kniegelenk-gedehnt-96476b242a09@brauner>
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
In-Reply-To: <20260701-davon-kniegelenk-gedehnt-96476b242a09@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=0.0 required=3.0 tests=SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:hch@lst.de,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-3800-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,lst.de,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:mid,lst.de:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 795006F5E4E

On Wed, Jul 01, 2026 at 03:27:40PM +0200, Christian Brauner wrote:
> Applied to the vfs.fixes branch of the vfs/vfs.git tree.
> Patches in the vfs.fixes branch should appear in linux-next soon.

Hmm, both this mail and the merge commit in git reference the first
commit instead of the cower letter.  Is there an issue with your
automation that made it miss the cover letter?

