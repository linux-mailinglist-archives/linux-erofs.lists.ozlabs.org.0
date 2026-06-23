Return-Path: <linux-erofs+bounces-3735-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XnVMDJ2POmpQAAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3735-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 15:52:29 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 209BF6B79CA
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 15:52:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=jn5S83jL;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3735-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3735-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=lst.de (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl62K2tVTz2y71;
	Tue, 23 Jun 2026 23:52:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782222745;
	cv=none; b=bnFkM44Tx63xcdQKpKv/Yk2935WPahNzHs4CApJYqBw0bjzfFvjEiy3aIcWdqTcGd07TzUVuvZdra2dFDeasUXhSt+SI5bc97xwl9NozS8Amo7becuo6uKh0Xs1tt3gXWS3Iym8T6QVrmnj7lEnCHmy8TG5gyoecArAKl9b5yySn/LbFxoOKMBVuNJtOqm4lu4ZLL6HvIALQf3A0zeNxU6HiSpPzD5w4MC3K+VCiwgSI3AjW0uA4nT3+HgMmJKXGtV9O6c6Y17J49y5kn89of16py6SCb/xeFylewKFggOM+tzjEJcMctewCk/Ks8y8NW6ddKbujEq+C1B8Be4eCMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782222745; c=relaxed/relaxed;
	bh=PoOEKS+eDTfInw4OHh9azlmGlb94rL+G6EWiMKCHpNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dt53gMImF5eW2izcToeneCqizsPrRAgtyQzQEOi68PEmyJhZXTxN3jnkyXe361dJ+Hysfloe9E4EiWMyr4nynGVWdSyFoV+aN1YJJfPF4Hjwd1IVbY7x0ayzsV8H1bDLqIMoW/+0z0A/CmW+sWdZujVIuBL6RSTHBYGrfJQ34JpH2eI6TbmpC3MouiX9JdGby1CXcsv3ksFT5xQL4EUb/47F2adJ5+cyWWrGce3GKSvUs/aOR+cHQ9ZAuitIOamKRblSHL+YvWV41aZiiFBDFUYFsTr++kZYmv1rn/j/VNFA4L0AEzJsp9TjyzQVUO/geITiLOmnaO0vN5bXHVQalg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jn5S83jL; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+1ce5920da89166e1197d+8339+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl62H07Lhz2xM7
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 23:52:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PoOEKS+eDTfInw4OHh9azlmGlb94rL+G6EWiMKCHpNM=; b=jn5S83jLuCl3m+DKs0KX2qnWLx
	m2yF7h06gH9mTy/pDA92JeRc2O5jP05jl4ogvEK0WS/W+H2H/z3IkvpjXXgmHUpvHT3sptVLvL7Br
	bdj61w5J3Idd4NY/Zsc55aMTtERBE7uWQwMF+2/Q1aC0sRMqxRDKFRxBcc5cshUtO69Ggren/x0SY
	h8pgGlgpkm4+nUORnZ/nDCZO9pXSB6IVG3ZOpm0ZJOk3keO0M185jKz4nbdMD+4nbb5wRCPkOSlA3
	1v37DXKZK7FKgA7oHSLZygJ36ECcR5KQ52Enk4r4EyA8A3DUt7SoRgfLPxdwc+/PDcp90jw/dz7GC
	VNZ4Ipsw==;
Received: from [2001:4bb8:2f6:ef61:5b2b:8638:3844:9408] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1Xy-00000006NCY-17nf;
	Tue, 23 Jun 2026 13:52:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Kelu Ye <yekelu1@huawei.com>,
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
	linux-fsdevel@vger.kernel.org
Subject: don't build bios/contexts over multiple iomaps v2
Date: Tue, 23 Jun 2026 15:51:35 +0200
Message-ID: <20260623135208.1812933-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
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
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3735-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[infradead.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,kernel.org,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 209BF6B79CA

Hi all,

this patch changes how iomap submits bios for reads.  The old behavior
to build up bios across iomap was already considered problematic for
a while, but we now ran into a erofs bug because of it, so it's time
to finally fix it.

It would be great to get the fix into 7.2 as the fixed bug can be
triggered by users.

Changes since v1:
 - don't submit fuse context after each iteration
 - consolidate some code to support the above
 - fix a bug in the fs PI support found while doing the above

