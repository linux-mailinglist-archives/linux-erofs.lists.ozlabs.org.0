Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6C4283D0
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:32:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFWT2ZSZz2yPh
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:32:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AViIxpKl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=AViIxpKl; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFWQ40ppz2xtS
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:32:18 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CA5060FBF;
 Sun, 10 Oct 2021 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633901537;
 bh=zjy3R1MRHvh/dkVHDeEdi/cGiweG0b5pfdrgoCBELzs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AViIxpKle0TJbAeKrLFAqo0OThzh+X4UdhiT4JIscES0EoA8s25+dLvLt6rSOfKbA
 YRG5tW79trrjgLHBhUNwtWg1a5SCotUSjn5UpSCPI2Rw5ucF2ctBaYUPHNNy55M2+t
 iXqgiKW1gCA9YQLgrmgrUH/C12hDVzLix8QHGvVzGL9r0wDMDMj+pj1KkxM4hYJ/d0
 gDzbK5FaPY1wBLv7h5bN15Ki7tLdaHcNRIRG4hehpjpB96L9Zm7fpHiEN/2vNDbFbn
 TLICYzbyz0zwGCzGw6uTyNexGct5RCoNhHKf7y3dFqyFlWUSnMBmZj+uJOykWOlG1I
 n3fqJB85l4gTw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] lib/xz: Move s->lzma.len = 0 initialization to
 lzma_reset()
Date: Mon, 11 Oct 2021 05:31:41 +0800
Message-Id: <20211010213145.17462-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Greg KH <gregkh@linuxfoundation.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Lasse Collin <lasse.collin@tukaani.org>

It's a more logical place even if the resetting needs to be done
only once per LZMA2 stream (if lzma_reset() called in the middle
of an LZMA2 stream, .len will already be 0).

Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xz/xz_dec_lzma2.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index d548cf0e59fe..22b789645ce5 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -791,6 +791,7 @@ static void lzma_reset(struct xz_dec_lzma2 *s)
 	s->lzma.rep1 = 0;
 	s->lzma.rep2 = 0;
 	s->lzma.rep3 = 0;
+	s->lzma.len = 0;
 
 	/*
 	 * All probabilities are initialized to the same value. This hack
@@ -1174,8 +1175,6 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_reset(struct xz_dec_lzma2 *s, uint8_t props)
 		}
 	}
 
-	s->lzma.len = 0;
-
 	s->lzma2.sequence = SEQ_CONTROL;
 	s->lzma2.need_dict_reset = true;
 
-- 
2.20.1

