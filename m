Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0A4A30D57
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Feb 2025 14:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1739282068;
	bh=n6zbfIsYyT/ulR1Xzt+AW0ggxLyjelpNpIOiYw9In7g=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QWS4s9ZSqqegFSqu3fhyxhxSgOiu3BhC40fplfeMkaiBN6Ll5DmSZfCkWSSjk3USr
	 hOQmSUzjmQaAs9cMXNJWCJVqvLMMLOcvOu/CdHSP9ak8r3F90qG8JuF3XBT4PIacBT
	 u+9T3M0s7iZtBpwxMpgJp/8NeIS7DMCO7mG6MKv9+6/spa3Smk+PeN2zRgEEDAsk4G
	 Gigb5x7X6ifIyDLmionV5ul9z4zroEgt93I4H5uT4ySTiMuSm1txD5UxjEKmhiCnKy
	 gDAeFdjd8qfnhUV/cTG8suTZhvokypZ2pEvRIdHp7RILCBX8TPRWqrKCHQL1dSeiJ/
	 +yfLwfDkevBpw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ysjc448htz3cF6
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Feb 2025 00:54:28 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=45.249.212.190
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1739282064;
	cv=none; b=ZW70kRxWCXB30HUQHzDyv7ADW/SGF/+mKoE03zmP5qtpBAe6pvRMMaAJ2FlV3OTkIQPqMm/mRsSTuotcHyU6ECzbcoQjJNxcdfeOPycowdviGJAQT3Ij6hAa/vvvqfZn5huzEYwbBOZMigC1YFcULZxYGutW3z0Fc6TX6vzjT1m1q0i1gP+k2XNGbtZS5mtkH732VhaJDM+3dYxKQeXGSqh+L1cmKRdNpAXuiB4RP2ortdho/Jv+rd4ctmr/wUXtDgm3DRsN0x9l0paI3T6DcuSiFXsXrfUGLIPgPPcmKHbVFfqGmK/ziCiSXC2LW4ERdzNEbwqSVRCLzlPxM2zsPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1739282064; c=relaxed/relaxed;
	bh=n6zbfIsYyT/ulR1Xzt+AW0ggxLyjelpNpIOiYw9In7g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcvBFN7ONUx4+WJf+clZe2kG77u4JnG+nSIEXLkiZJC3mQBSGphj6q3EeJZFdielr2M63FeIJXQI9ibIxqGLUvUz+FtKJDhodAiZCa2ej/cMAQonIBmfmliTGrB7WwJlEPV7usxtsH2IjfQdpaxqGEqULBtFJoHMrY092WLAkO2V37noqDpuatlcphUlDLwGccgnykOSYN/QbqBL55WncPZ4ZpzVvyEWyRSJi54k1uJQmwAlNNTyPaRLVldkeqq0vzyHkC4TiJLggfaK3c6xNEq+NI650YAo7Gl151ejcwUR2Wv3hDpXjzCp/mrUWyJSjYd+Wnkd9O9ZZEiygEzA3w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.190; helo=szxga04-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ysjbz4Y6Mz306J
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Feb 2025 00:54:23 +1100 (AEDT)
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YsjXV2LvXz22mvt;
	Tue, 11 Feb 2025 21:51:22 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 38C141401F3;
	Tue, 11 Feb 2025 21:54:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemo500009.china.huawei.com
 (7.202.194.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Feb
 2025 21:54:13 +0800
To: <xiang@kernel.org>, <chao@kernel.org>
Subject: [PATCH v2 0/4] erofs: file-backed mount supports direct io
Date: Tue, 11 Feb 2025 21:53:27 +0800
Message-ID: <20250211135331.933681-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemo500009.china.huawei.com (7.202.194.199)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs has add file-backed mount support. In this scenario, only buffer
io is allowed. So we enhance the io mode by implementing the direct
io. Also, this can make the iov_iter (user buffer) interact with the
backed file's page cache directly.

To be mentioned, the direct io is atomic, if the part of the iov_iter
of direct io failed, the whole direct io also fails.

We conduct the basic test on direct io and normal io, the fio is used in
the test, the results show it can decrease the memory overhead. It slower
than normal io in seq read due to erofs page cache and readahead, uut in
rand read direct io is similar than buffer io. The results are reasonable.

v2:
  - Reuse the original erofs_fileio_scan_folio logic and do some construction.

v1:
  - https://lore.kernel.org/all/47f74598-1b2f-4308-a8b8-18fc40bafe6d@linux.alibaba.com/T/

Comments and questions are, as always, welcome.

Thanks,
Hongbo.

Hongbo Li (4):
  erofs: decouple the iterator on folio
  erofs: decouple callback action for fileio bio
  erofs: add erofs_fileio_direct_io helper to handle direct io
  erofs: file-backed mount supports direct io

 fs/erofs/data.c   |  10 ++-
 fs/erofs/fileio.c | 170 ++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 148 insertions(+), 32 deletions(-)

-- 
2.34.1

