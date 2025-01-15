Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4270EA11E72
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 10:47:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YY1PP1Gw6z3c5Z
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Jan 2025 20:47:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:7c80:54:3::133"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1736934439;
	cv=none; b=l4WtAvM5PQVrPvnNE4TEVXXXT+1a94JJVk+pbvVcPUm7FN2D9l2M3/x3mRBsZBzRVgvvTEvRyf6xUgd7QuhMmsbW8D0IXWFnV+4Wlp28o+TgzHU7DftmO9Py4jLtPAULOLTCUFSjrPD5EMHfw0K7qHK1lMvXnFjoFGhvvUpBaKbYVuTec4sqwic6Z41kNciHkoVLKYyNTDacyPOCt52nDEg8e5x+Ju1/4FxwdJ2BBb35yIjKJRApC9seHqGYIscZMxkDYRCV8cuwSRq4P1W3+cuhQJCxnWLcFCI/4tvnKgDG2raDJvrKYeSUCtOFTWu71jFLyPQpYLnIrLgVgPNG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1736934439; c=relaxed/relaxed;
	bh=JLpZrvaMc6GV46XbuHZJmt3meVmUGd1vvv0MgNmLkC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iyD81uXHL5L1VC4yg7dFrBj5GZhCAN2pIskilv1IyjGzTvIXFoQ8XQNdIj060U9aX9vhf29txx0egEEt1jIXmBF0PDQm1nMerCmzp2fEynZJ0VNZY0wPYy6bTeSo5Rk3dRx0WOqTUZ3MO3fVu5FjESEqObIeJSWMznQRD7WVsYHzIaCK4xkdkgKQBe64VvFDECqtrRVa7Ya0i0iD3Ood8OCtiHKsOmQMlrR7tG6HVr9tYIAeEDPTPrgFIqgDz6ksgfPkcITNLdRUMrV/vtyjhWebv+kgjmezL8Ax6LpFcTD/IZt8fA0Yj3Ja7NTyHfO8Ag8Y9MXD+oknSOwFvlSbtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+33aec566f0caf243ce7d+7815+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YY1PF6Wb2z30fM
	for <linux-erofs@lists.ozlabs.org>; Wed, 15 Jan 2025 20:47:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JLpZrvaMc6GV46XbuHZJmt3meVmUGd1vvv0MgNmLkC4=; b=vnWbtQWrrFbO8X0TgMRPAb3tVY
	2brCcEi1EjC/IEN5Xsm0cmRxzMpRg0Me95z04VjUJTfhoGUxgkc6rtgyCkdSRg+3U0O0D1uCWlZx4
	2noVjW6ZSw1ew2Fd0Buq0vq6B/oKRzzZOeSWtkb2zJBcY+c/7pZkPksFZ6ah8B2Fq2Jr1G5VflSJO
	77OftBY7nev+P89M32xt+VzoLXQxKgjhiJC7+JqZ/H1Oqs8NmDecshwkBsCcM/kNQqhBfVvUmLJbE
	hh2hDAz9CNKsT+1PBSp9p9CuEWRUs6zihfOmiTLkm+CIEW9h9Ch7qHw5l775qXw2QsqrNhHWW4Etx
	loKVmrIQ==;
Received: from 2a02-8389-2341-5b80-7ef2-fcbf-2bb2-bbdf.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7ef2:fcbf:2bb2:bbdf] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXzzS-0000000BOdo-3nru;
	Wed, 15 Jan 2025 09:47:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/8] lockref: improve the lockref_get_not_zero description
Date: Wed, 15 Jan 2025 10:46:38 +0100
Message-ID: <20250115094702.504610-3-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115094702.504610-1-hch@lst.de>
References: <20250115094702.504610-1-hch@lst.de>
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

lockref_put_return returns exactly -1 and not "an error" when the lockref
is dead or locked.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/lockref.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/lockref.c b/lib/lockref.c
index a68192c979b3..b1b042a9a6c8 100644
--- a/lib/lockref.c
+++ b/lib/lockref.c
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(lockref_get_not_zero);
  * @lockref: pointer to lockref structure
  *
  * Decrement the reference count and return the new value.
- * If the lockref was dead or locked, return an error.
+ * If the lockref was dead or locked, return -1.
  */
 int lockref_put_return(struct lockref *lockref)
 {
-- 
2.45.2

