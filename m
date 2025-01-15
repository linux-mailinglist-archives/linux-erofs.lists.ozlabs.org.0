Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EFBA11E71
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PN67vxz3bqh
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934439;
	cv=none; b=fclQKkLsxUYOixDMSeI2XNYs3vbFzB1ZJOI9gyiZBbpEQkYIqMVho+CIrX2hs+EJ7cKbo9tFISL7x3fQAuzIPIwe3SK383orYEkLHBnfMleuafMIVOsFcfXB8Y3BVG5lw6LmXJgghSB/E5htFJP4vAKkFS5pIHcEXQaArsr1wKLxm2HBxnWhZM36+kK9dPO5HdgtNjCC8CdLBC2M4LPRBWCItuFVWgpjRgNTLHJlh4Ahm09hdy0iUs2MmrnYkkvFSJ1HSo0a8EvcCTml/YsoD5RiT6TLDU5LJPch+zhklRvguCX4FqWCOQUsce+1pvnO3my1E8jWKgUuaVktboF14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934439; c=relaxed/relaxed;
	bh=jLQVkcSbqBBJ/uTGQd84Plp3t7x5dzC33gGhCpomRHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CvVPYGFfJKqxUmy0pnGRAxGjMc9B+EsAi8p5KxvC+zv3l+mRXdxYcRPYM+ZfGhsG6D0B9uhGkr5WMIwc/onKh3qU6Kwtutxb2o9KENiCKDCoM9maF4gwMZHIFwlkb/X6Qg6mznWwQLPaqneoza2LfUEgHl8vSGWSjwskbr2qC1piqs+N2GQlvUVP2mbZdrZYKiKKK+l0vnzcqGUtEgTRmdkFyu73PhjQcaRMGa7X+lvxg3ztmcRpf7x5yWfu4LzfesyJALSaDvKbteasRmc5LnQZJm/Rl+/huVFn4gG5/fFeIWtdLDfJ2V3jKO58hzJbp7mJyCrljyx9RtlqWPY6DA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PD1H1hz30Wc
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=jLQVkcSbqBBJ/uTGQd84Plp3t7x5dzC33gGhCpomRHo=; b=CL29udPt1/lIP4m0NjByfsQWZd
	bU3ta/e6R7VHcbH1UhF/H/q46vy2HYnBQxYDONpIrA3Lo8eLZ2Z2rTZW7gZBFjjmdFTl9Eu+T4J0a
	EtUh4FOKP9mw5+pIrIHRHOgnBN7H/wIiQcEKdSKEeoD9zqlkpwXAnDwAJhpHAswn9zI+sRValfnUQ
	AwWirdaHv3WEZsl0avZ4FWUWcY8OrvhgRHxMeeE50SVKpC6wW+8LmCjo0oCzFwxqQxGureXp04hww
	XCx7SOzY8vn989mxolOM7qh0utfkM6LjpEUneJ0OBgS0r4N3IcHroytPpvz7mth8c97BIMteQXsJx
	ln0GX48Q==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzN-0000000BOZp-30xr;
	Wed, 15 Jan 2025 09:47:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: lockref cleanups
Date: Wed, 15 Jan 2025 10:46:36 +0100
Message-ID: <20250115094702.504610-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.0
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
Cc: Christian Brauner <brauner@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, linux-kernel@vger.kernel.org, gfs2@lists.linux.dev, Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi all,

this series has a bunch of cosmetic cleanups for the lockref code I came up
with when reading the code in preparation of adding a new user of it.

Diffstat:
 fs/dcache.c             |    3 --
 fs/erofs/zdata.c        |    3 --
 fs/gfs2/quota.c         |    3 --
 include/linux/lockref.h |   26 ++++++++++++++------
 lib/lockref.c           |   60 ++++++++++++------------------------------------
 5 files changed, 36 insertions(+), 59 deletions(-)
