Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1980D7A918D
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 07:26:47 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P9StZuXW;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RrkR65fR5z3c50
	for <lists+linux-erofs@lfdr.de>; Thu, 21 Sep 2023 15:26:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=P9StZuXW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=xiang@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RrkR065PXz2yW7
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 15:26:36 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 4EB0C61E4E
	for <linux-erofs@lists.ozlabs.org>; Thu, 21 Sep 2023 05:26:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0250CC433C8;
	Thu, 21 Sep 2023 05:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695273992;
	bh=oQgXqRH4TbGWpJlUvoHBdjoOwt4zOqrdiEDUsYfuq1w=;
	h=Date:From:To:Cc:Subject:From;
	b=P9StZuXWWGikAH2n3LYkf2kpB7puiZHevN4RXgHSDWRyPTcbIrZ5d2DR7S/8a6ITb
	 wtv7Vz96XoiuYQQqeJoc1/YtUu4346DAy6UubmLxiYTG4AYkcxV7mTMFsCPDu42f8X
	 o7zJAJKehS+AgLxwfcks70JskoulkHIPihWjAkXkLBdQUh+El5/kA56IJZqKHuFIl4
	 WQu5jDGporNJyIuO2yTrBTDlMMPAhjbRox8SUfK0EH9NOvIf4o64qECcWLJqniFFNI
	 xHDbxcE7K5xG00JgAo/gFrp7EKKCBUEVUPCak+nFALPZWm3bW0W5vMp0iQIit9/v5R
	 1Z4aQTjsFYoOA==
Date: Thu, 21 Sep 2023 13:26:25 +0800
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [ANNOUNCE] erofs-utils: release 1.7
Message-ID: <ZQvUAd8r50cTK+s5@hsiangkao-PC>
Mail-Followup-To: linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi folks,

After almost another 6 months, a new version of erofs-utils 1.7 is
available at:
git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git tags/v1.7

It mainly includes the following changes:
  - support arbitrary valid block sizes in addition to page size;
  - (mkfs.erofs) arrange on-disk meta with Breadth-First Traversal instead;
  - support long xattr name prefixes (Jingbo Xu);
  - support UUID functionality without libuuid (Norbert Lange);
  - (mkfs.erofs, experimental) add DEFLATE algorithm support;
  - (mkfs.erofs, experimental) support building images directly from tarballs;
  - (dump.erofs) print more superblock fields (Guo Xuenan);
  - (mkfs.erofs, experimental) introduce preliminary rebuild mode (Jingbo Xu);
  - various bugfixes and cleanups (Sandeep Dhavale, Guo Xuenan, Yue Hu,
          Weizhao Ouyang, Kelvin Zhang, Noboru Asai, Yifan Zhao and Li Yiyan);

In brief, this version supports tarerofs, DEFLATE algorithm, and new
on-disk features to help the Composefs model.

In the next erofs-utils versions, we are going to improve mkfs
performance by supporting multi-threaded reproducible builds and
optimizing data deduplication & metadata flushing speed.  In addition,
other enhancements like erofsfuse improvements [1], hardware accelerator
and preliminary Zstd algorithm support are on the way too.

Comments, questions are welcome as always, yet time is still needed for
them to be landed (EROFS upstream development is a little part of our
kernel jobs).  It's always worth trying, and any contribution is much
appreciated.

Thanks,
Gao Xiang

[1] https://lore.kernel.org/r/20230918090306.2524624-1-lyy0627@sjtu.edu.cn
