Return-Path: <linux-erofs+bounces-3798-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Qr2zKO0VRWrp6goAu9opvQ
	(envelope-from <linux-erofs+bounces-3798-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 15:28:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D5F6EE1A7
	for <lists+linux-erofs@lfdr.de>; Wed, 01 Jul 2026 15:28:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QBkIcOoi;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3798-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3798-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gr16d1wfhz2yfs;
	Wed, 01 Jul 2026 23:28:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782912489;
	cv=none; b=b7SpWvNUS467o/pY3nSAHJzgKwnUG77eCcxe5WogpJulOD2ZaMD1U+H4bYCGysUkFAzTkA0ykBH1cqXcInV3TaEsJVcMaoTtktb4HismOrVJQ6i9KL+ubxGvyFSIbAmip36OakrozTY6G1e4DF9Ev3YTOoJNTyg/OJUUcCzhJcd4N7utuyv/f7H2UMxzdhfNymRutX5yBsR9giSw8uA3H+GEUSwis88So5J4Heh4XZ39j4zg7hW2eNa20++KI3v8Qg5Zh3DyYa5pzdHNyOha1pH3ey6nzxV49BNwOLFTPhZzrYmIJddgij/YdU6J/i06lZATQPo3nH1OBMXHISftmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782912489; c=relaxed/relaxed;
	bh=S/ir4WC1F7FyETK8VqjWLb5Y+h//+o4RHG1aeGMPGPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJ2ekJqmvmNhHAQdKlh6ZxFe5f5ZL1F2Q9gbshBGcLbcPURxgOz0vxu3QmEPs6vQojeSJp3p3ZFNKYL/qk7ZilIzC8ZFoeqyNT74lnGShWcM/AkdXzmzcLaIWHSsIeGCKZ8GbsBWSKN6QjEKMTdZX/lq0d8MQMf+8IR3fVT01LhlcRMfAjDNnCG/omgUwExMYztfrbiFH/jbmy3mUqS2pggtXdJC3ycZ+G8McWzFyRvNPglGs/7sEgyHCm2vyOvL8PrJmZjYvDm8UMsptoTihdi1KKBr14lQtqsWNuov6e5Z0kHzvQgjN+l8TqdnrVj3jmlNJ/ICveDsDlNlLN0f5w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBkIcOoi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gr16b619Fz2yfS
	for <linux-erofs@lists.ozlabs.org>; Wed, 01 Jul 2026 23:28:07 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C3866001D;
	Wed,  1 Jul 2026 13:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE62B1F000E9;
	Wed,  1 Jul 2026 13:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782912484;
	bh=S/ir4WC1F7FyETK8VqjWLb5Y+h//+o4RHG1aeGMPGPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBkIcOoiSZQuYYK7QffAwCNm8VaK++eXTg9AS9VzPGwSsZmNe721QfD5tLz0b5Ljb
	 ERybIPZ7UuKg70udSUh9Q7eOo7zB8AJYJB13RW0B0gKO+zjDFlqE1pfKCrU+V6INxn
	 TlEjtN0MBdNs7Feqv9TDr/7CiYC0dt+iiVMhTx+dNJQMW8Ld8IphDTJDZjDp7Umn5F
	 M2rvGjzuDP/DBJUpfAARQoQ8IeDuScYB4VkDJwESKSuVGxquOomHKsPgr+z5851UJb
	 FNRZI4ms/t9yiUs2jrV1bdlAXEQSYynE3g4laKriuldFn2wUzcnPKXLr3Prazk95Xv
	 ZeHqosXQ2hpXQ==
From: Christian Brauner <brauner@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
	Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/3] iomap: consolidate bio submission
Date: Wed,  1 Jul 2026 15:27:40 +0200
Message-ID: <20260701-davon-kniegelenk-gedehnt-96476b242a09@brauner>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629121750.3392300-2-hch@lst.de>
References: <20260629121750.3392300-2-hch@lst.de>
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
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1819; i=brauner@kernel.org; h=from:subject:message-id; bh=iKscDZQfy0MtN4T97LK36aJevrKA4UAXQeqiSYbMIyY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5it7RsWDc2sutssqLV0pi/oIv7G6tQj4SdWfS564sN 1S5YvS9o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCK3IhgZXn05sNjoiK6LmpzZ kcUpV9dIfso4M2nzmZJgzb9SPNb6lgz/9Pi6PGc+u+HOtq8gTdxvdnHqPs1ItmXMtw7+cZHdLbG KGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.80 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	TAGGED_FROM(0.00)[bounces-3798-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:djwong@kernel.org,m:hch@lst.de,m:brauner@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[kernel.org,huawei.com,gmail.com,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[brauner:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B6D5F6EE1A7

On Mon, 29 Jun 2026 14:17:38 +0200, Christoph Hellwig wrote:
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
> [...]

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/3] iomap: consolidate bio submission
      https://git.kernel.org/vfs/vfs/c/044472d5ee7d
[2/3] fuse: call fuse_send_readpages explicitly from fuse_readahead
      https://git.kernel.org/vfs/vfs/c/3372eb0384b7
[3/3] iomap: submit read bio after each extent
      https://git.kernel.org/vfs/vfs/c/c1fb97d31782

