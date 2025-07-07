Return-Path: <linux-erofs+bounces-536-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341EAAFAEE5
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Jul 2025 10:48:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bbHvz67cfz30Vr;
	Mon,  7 Jul 2025 18:48:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751878127;
	cv=none; b=o3vgnzmZIeFTO8fCpot7Dgh0r6Sc56fjku9Qcdf9NBl508yPZKPfWUUxM1E6lHD6tE7LbaJTwsy4WUygsVsNRDOhOI1AjU5Tt9ergav6zQkhNhi7z1baCmThBcs2+DZ1KN2T/CqQRkZZEQ8nwg6nnVxzQPUrOxwEnbqEwQiqb5nsn/289oeew3ECLJQMuGIY89lw2Ip40A307sCiW8EOfVWpJo7u7DkMt3E2B66u1eYdqoZ1U+VfNEjagLdMMe+XEfnft6Aa2e3oyRzYcVOgCQETJb1Qy6hY4OmS5hsbQA6bIfnf+nEkJ0ujZD5WmqKayBP3TW07zZ773yMDq9J/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751878127; c=relaxed/relaxed;
	bh=FAT3tupZYF7Uzzzz9/eZ6BjUCI9C0uWFBBEoYbvjCY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHXmk1thEHpbEoAsYTCx6HE7wCRUHw9o6AzhLuMLZ+iq+cfKQuiHcLUZgE52whNSvxNAM+TsnioslUa1OaltLCSTYZoaSJXoyZlSJI9hYEfPtYOfw5Vdv0ylTsN5N5jMt2NoBZs4C2P/KiCVDx2e9o5elS1psJWQw0CS+InohoM6NJVTYMAGmWAVIwkSs/bCS/j6cNZKsaA5ugPn9wR7pdIGlftxDGdLd0oTZtDNVhHXuyhlIUbJV8bF+jamAkKCJZ24n8UTVSbDIkQgFpqNDmFkkVvyf9FJgOFpSGN2RnJ0KXu9HncWJ0A0SqmaCtJPaYMgx4aOPrdRL4UX38CogA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KcI49CtW; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KcI49CtW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bbHvz2PcRz30V7
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Jul 2025 18:48:47 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 25D8B5C5B5C;
	Mon,  7 Jul 2025 08:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2713C4CEF6;
	Mon,  7 Jul 2025 08:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751878124;
	bh=uiIk70uCYwETE2dDCVRHrmM+gZH1tMbl0071RZi0VdY=;
	h=From:To:Cc:Subject:Date:From;
	b=KcI49CtWXHDjyhTOkMyYB2HvRWc/FzkQodgzcKnxVdaVM2fbDwc9UR/E9g83ZN7r8
	 iI9X85SdKziFouceKFOXI6rp7yglcHiar5ngNx2JAIpG0FMuO97j+8ZSvNKjUPHrat
	 hHnfJBU4lEnCaV+ayx5jMJ4WSbM/cKbG6JZH331Is5/2aHR2rTH0zKrPpcwuCLfwEX
	 7aglVQt7oU1+XOItw7jyxMhn7SxbPmEkbcr73suL0l1r0j0ldU3cknTKwSfMHK52XO
	 KO2pc1gGnNQ6Nb959SpfDB8lMBzKxZKz7OATN9JLarOmwFxgIrBIKfcFAl8fFleoZs
	 PaaS2IbtX2+JA==
From: Chao Yu <chao@kernel.org>
To: xiang@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <lihongbo22@huawei.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: fix to add missing tracepoint in erofs_readahead()
Date: Mon,  7 Jul 2025 16:48:32 +0800
Message-ID: <20250707084832.2725677-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
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
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Commit 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
converts to use iomap interface, it removed trace_erofs_readahead()
tracepoint in the meantime, let's add it back.

Fixes: 771c994ea51f ("erofs: convert all uncompressed cases to iomap")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/erofs/data.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 6a329c329f43..534ac359976e 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -356,6 +356,9 @@ static int erofs_read_folio(struct file *file, struct folio *folio)
 
 static void erofs_readahead(struct readahead_control *rac)
 {
+	trace_erofs_readahead(rac->mapping->host, readahead_index(rac),
+					readahead_count(rac), true);
+
 	return iomap_readahead(rac, &erofs_iomap_ops);
 }
 
-- 
2.49.0


