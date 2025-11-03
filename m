Return-Path: <linux-erofs+bounces-1317-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA5DC2B533
	for <lists+linux-erofs@lfdr.de>; Mon, 03 Nov 2025 12:27:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0Tp73bLYz30Vl;
	Mon,  3 Nov 2025 22:27:27 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762169247;
	cv=none; b=FsyxZunktl9EQz67zyfMidro+YWluHnHnWt/AjfFW4A5dsCuNk0l0trr5pHRaWPd/kvtE/QuFtUXuB6VYcEo5A91UheN5q7B7RI7teUuCDY/5/OWkAbZsWVNPUxRwNkLa+slI0xKRULQuZ6OTjrnABPrcJNomZN7GIyo6e1UHuFBBOSLVy5giHtsxgH5s83jXpdXtt0sNkMHk3pCrmAduAmmaXolL2xHDYPS+wAYsVp9LRG3rN7Wlhna2ui8XfD9scccTXsLp4ASzQO4zbIi/Rz0ApxCtpvS9Zf7ZUUdUgiFoiE4EEyKvg4f7u15NprAWo71wHL1jfXdr7FbOsD6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762169247; c=relaxed/relaxed;
	bh=Ptqk+diTu9jxGJHMh+ATfEQK7n5JXYsnpnjcgxr580I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZK7xkWUtIxKTy4EPWPtqGaELliAJz0/gW9GZnl+13TvJ+RGjZPnVjsku4IIwp2h4nafy+7xVGaVo9Lr9h8qjL8uS7+qBIAXEsL7ANN7o9BM//byjLCOt0Jyzaxq50tjKMV+4lcy2gB1wQQc87NbheOQ80YDNCaAnxxJmhvsMrx1E2Vq9o7dy+TigPjbqNow++y1j1743wZcj3hxlCXVA9/jVxgI+PqXlnKrbMvPJgIBnx+eO97PSczMujHjMtO3dpfKMI3tOU6EMJOFJBwKBmidXlm9qNYui+jfLIvuQ1ihS8jKaVacsWrDFpE9dcErX28JwOEDUhq4MQwCMykv9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dSJOLdYs; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=dSJOLdYs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0Tp66r9qz2xS9
	for <linux-erofs@lists.ozlabs.org>; Mon,  3 Nov 2025 22:27:26 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 0C32B6013B;
	Mon,  3 Nov 2025 11:27:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4214FC4CEF8;
	Mon,  3 Nov 2025 11:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762169244;
	bh=mlLhVVRd/xxD3/60oVSWrFdPcpqIel0cuCN6B/lJA2U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dSJOLdYsbOtv8x75jqQRz94Oo7UCb7902vSZu0lMMEMCXX/RorZSIkWG8wMed0DWX
	 Ouy8AGG2Fk4WbaOjNzHC2oj3oZgQz3oknW5LY+JpTrie1MhL2dYKPeI8Z/JKT6rbIF
	 Xdn+JLAllNO5yjbH+XulE9RPblj14m06XiM6A7MA3VtBbJYHXSWd58SvLppxpaWaxc
	 SPZ5UeZvxHBPP6kfNsq/eg4oSKVdePHLrKMEM9nYnEEzvLs9V7QIEX9/NqClTOITqR
	 HJQqn+BrCZ8jtneil1XvrBoe6VXIjMjfOLZWm7vksU/vRSN03kt5Vs3y4oZqk2pw9Z
	 He0fs7fz/JbSw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 03 Nov 2025 12:26:54 +0100
Subject: [PATCH 06/16] backing-file: use credential guards for splice write
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
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-work-creds-guards-simple-v1-6-a3e156839e7f@kernel.org>
References: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
In-Reply-To: <20251103-work-creds-guards-simple-v1-0-a3e156839e7f@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 cgroups@vger.kernel.org, netdev@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mlLhVVRd/xxD3/60oVSWrFdPcpqIel0cuCN6B/lJA2U=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRyTGzXdZtwz9bEwErmpcLqufXHk27pXpnv09HpmZD0Y
 Y6C+a20jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIlMlmT4Z7vMQkfcbFZTvPjK
 Ewmagtc3vf6j5+nFsSeJ/4GEQ3oNDyPDlF/cWhO2zF8gfDJJW6Ut7fjsf/KJewqqFmuk6rpyt3j
 yAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Use credential guards for scoped credential override with automatic
restoration on scope exit.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/backing-file.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 8ebc62f49bad..9c63a3368b66 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -303,7 +303,6 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 				  size_t len, unsigned int flags,
 				  struct backing_file_ctx *ctx)
 {
-	const struct cred *old_cred;
 	ssize_t ret;
 
 	if (WARN_ON_ONCE(!(out->f_mode & FMODE_BACKING)))
@@ -316,11 +315,11 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (ret)
 		return ret;
 
-	old_cred = override_creds(ctx->cred);
-	file_start_write(out);
-	ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
-	file_end_write(out);
-	revert_creds(old_cred);
+	scoped_with_creds(ctx->cred) {
+		file_start_write(out);
+		ret = out->f_op->splice_write(pipe, out, &iocb->ki_pos, len, flags);
+		file_end_write(out);
+	}
 
 	if (ctx->end_write)
 		ctx->end_write(iocb, ret);

-- 
2.47.3


