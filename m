Return-Path: <linux-erofs+bounces-3782-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CsUQHpZiQmra5wkAu9opvQ
	(envelope-from <linux-erofs+bounces-3782-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 14:18:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8C26D9F59
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 14:18:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b="Xa/6fOwI";
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3782-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3782-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=lst.de (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gplg73Ptnz2yZ8;
	Mon, 29 Jun 2026 22:18:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782735507;
	cv=none; b=jd4TomURh5gQy7eIfHe6IoexvN1Gr5nROy5ZvITw2Wgwrf4iPqHiFWh32nr/7rB4pST6E0L91jxIa5ZOknAKQ9kt4SsFPDpMq3sAKBqk8PpzXy+oG/WO68uwNUdkXAudjGuOeRH9douPTpYgOmx2vA+TcbFd5gOgdfMna035244yxNXMmAZ47LenGgkF4NhGlwwHmcRYLX3LGnuIHtZLfRfyBYqqXSX5NYjWE4chCDdDzBg47ZiKBXxoUOFY9tAd5BPEu3fH0StfxRdP2mZiE9kWZU8th0VEwrjieRH6BIt+7kJERkQ2C00yMmZk/xDFuKMZkdE1vIqwBISQCyszbg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782735507; c=relaxed/relaxed;
	bh=v898+QkB1UDAKWiTlcnqdkDW1C2WbAo9fOIytjJGE+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DD6ehO91hSk8d1bVIHFw3uj5rL7c8j33ugXg4Z/x9rtrdJ81jaGYlhSBX87OLuRjHvT1Z+dZfWNWKHt//u+gqypybzHj2JnN+bfHrAA+7X4M4kbBUvRvVyRCiIp66qPdnkUKDZ9UedbtkSKw2mR6urAbH2hfz1GWqWxyZnL4nBY8WNlkcnczJ6jQOOitWK24G9ysFs0lVXcCcyPaO023Kpp3ykTl4GuoTBKrKzA4x15NJFJyxjwOtsgEydJHQavRtBH49c0qZIzNavJJDb9Hbm3ticPHzWfSyc5rd3mPZGRxoy1xODN37UZVJxkjfICseWKoHidNkv1I2IMh3fn0dA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xa/6fOwI; dkim-atps=neutral; spf=temperror (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+90a5730460baaf6f6760+8345+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gplg63Mr8z2xYh
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 22:18:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=v898+QkB1UDAKWiTlcnqdkDW1C2WbAo9fOIytjJGE+U=; b=Xa/6fOwIwXnUiihMQCuFbBCt1l
	LpE+6eJtf9J9rUjXsdqp/TyDk9l+UMjKFhyiR7+feG1+zLWMmIcL34TdcZT5hai0zCepUx7yepQJo
	qBjiMd9vE7vLxOEKVmG7z0AAzhohqY4dsUDfSS3f9hx4gGrN8iil0CCpM7qYTUIlfvfQKjegwXYfc
	m1fEO120AVKanyGRkZJzZ5hf12yrWyTjPBEA0Uvfx9RUZNcGsgk68qJNDqAKTS6Q5AZcog0yJC1X1
	FkziMp68z/OvI8z43NZ36VNCqkc08xZm5Jv0uzi2lEuAUx1VsR3DPiTgNMzCtfx/FTcAMV4ytIEA3
	XxcngfRw==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weAw0-0000000EWzb-1HZn;
	Mon, 29 Jun 2026 12:17:56 +0000
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
Subject: don't build bios/contexts over multiple iomaps v3
Date: Mon, 29 Jun 2026 14:17:37 +0200
Message-ID: <20260629121750.3392300-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3782-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9D8C26D9F59

Hi all,

this patch changes how iomap submits bios for reads.  The old behavior
to build up bios across iomap was already considered problematic for
a while, but we now ran into a erofs bug because of it, so it's time
to finally fix it.

It would be great to get the fix into 7.2 as the fixed bug can be
triggered by users.

Changes since v2:
 - drop an unused argument
 - make sure we submit for the same iteration to not leave a landmine
   for future changes

Changes since v1:
 - don't submit fuse context after each iteration
 - consolidate some code to support the above
 - fix a bug in the fs PI support found while doing the above

