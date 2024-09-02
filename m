Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 66306968142
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:04:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725264271;
	bh=wFa0bUtxKzChSqtQYzvAr8PoFVU794YULGslHHrtEsw=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=at5RGbA/F1XtgGtc4cHeb3ni++gx5mYy7Dsoqm7Gol29d8ACQTwmNSsd93JJs+CoA
	 glhuaVq3aNXBnAstO6LQoZJjFvJkXyz3fLBUwHsGcTnXl7/qPO54DVrRqgDuPWw0ss
	 dMo91T/Bc/XHOxQxx7/vi8yOE9/0LaqxE1dkJtozKt1izPaqaUoWNtiSeEy35mHOST
	 f2a6u3oLRCYelu4GzBxzO00uUjphYnJay3jDjTtrBLaCB90O9Z8qHS00WWmjIgBVjK
	 O2sL5wmTx0/PGccyMw+DARfedkjg4qeGxLDFAXf/A3qdB6fb4iQtjDYVuy56GIJWOc
	 fRNbnG40QvJyA==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy1W30Dwhz2yNc
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:04:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725264268;
	cv=none; b=AW5VwZua7Zxwt0M6DP2ggKHoomeyiw/Z4xbHCOZ2/dABbYGF5g1qStML0rdizLI10jwzhmnu+maAfLyEXYw3aByEePqHhpgLAG7t+QMXS6mj84o4iCGzZRWZcGwQxw4Ym5Y+pAa9zOiC0DqctlTFUSb/BhEkcJsWrnWuSJqk7tq83coRaLMhn3IGfgbWrW26gdv1IC1dL/gny8soO0kCHoLL/wbCpGj9KpLGgMGnMffzQQA9WtMvr5nrUWc9Toe6OKAlKCzD1Pw4i5pLynIuuP7CZxtlsnyA0aGl08Xcofs3DWCd4aCf85RcW395gs2v2JJlDQL1Cp+UQqHwV++hSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725264268; c=relaxed/relaxed;
	bh=wFa0bUtxKzChSqtQYzvAr8PoFVU794YULGslHHrtEsw=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version; b=IvgkUSSGjSK5sLkrSp3iJxsdU9ESNOLG3K1I3tdLU8SGFDrIwbS+BcgVuFbeGMEN6y0ZtdIA7e5rhRNmm1RVOCkHWkcvSZysr4g4xzreM1tJVMKol5clTUAJRBks6uCEoqXQ5Q/vY+FSd4elYkHtKpp2lWf22z1GRoGUo1T7WNYExriAZNZlvH8Hj62nHhLQuUEPbRh3+kL56/UIlOTPUntUdSGmHB3pUe2s8tPdcBsSdhF5xrKI/Pm04kkXroJ2XXRoKCHywf8GGoh2ubGy/ZoeSzRDwzFzG6h/K9I/NPAZPT9nJxRVwAeIXo6Y5aWoZuSugtTiH7pRQRMeaxwFCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=mIJRlvSU; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=mIJRlvSU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy1W05Q0Xz2xYY
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:04:28 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E83769799;
	Mon,  2 Sep 2024 04:04:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725264266; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=wFa0bUtxKzChSqtQYzvAr8PoFVU794YULGslHHrtEsw=;
	b=mIJRlvSUS4KZ+4sN9KyZk1kedcft4xYmYViJ8wa/d7ShbOX0sXbvbxZT/CW7Y9Fd1Eej5f
	qy5eTgqqUPWphFBCc7IxgDiuO/V6lKia+4rubmgcz3ydksUj91qKdr8XH1SsLRfVjUHglz
	jeRxavKbfXTuQHQeGWeUxPZ9reyWimnS8bgSBfwaRz8NHB1kj6U8ZYOiGS6+DcB6Vf77b5
	OdoDMKUbw1nfNI4kKQ5qyR59wRtNxWdsgbowT9+7mn59w5Sw4BZkcHG8GAhmWxgJ/M8Xx8
	xcFCjTeYebzFwO83UjWLlBRABbuSziwnkrCdihfEhHGE/8dAbxUi0OiYxqZCPw==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V3 0/2] erofs: refactor fast_symlink and read_inode
Date: Mon,  2 Sep 2024 16:04:15 +0800
Message-ID: <20240902080417.427993-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patchset is response to the original suggestions posted here[1].
Since my later work is somehow related to this issue, i think it's
better to deal with it first.

Changes in V2:
  1. Lift the erofs_fill_symlink patch to 1/2
  2. Fix code styles problems in read_inode patch.
  3. Fix the formatting problems caused by clang-format.

Changes in V3:
  1. Remove some redundant variables and statements in both patches.

[1]: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/

Yiyang Wu (2):
  erofs: use kmemdup_nul in erofs_fill_symlink
  erofs: refactor read_inode calling convention

 fs/erofs/inode.c | 126 ++++++++++++++++++++++-------------------------
 1 file changed, 58 insertions(+), 68 deletions(-)

-- 
2.46.0

