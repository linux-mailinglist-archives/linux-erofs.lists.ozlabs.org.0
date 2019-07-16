Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B3F6A293
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 09:04:41 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45nrxL3ZswzDqNg
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Jul 2019 17:04:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nrxH0rBRzDqKM
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jul 2019 17:04:34 +1000 (AEST)
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3D7E3C97C229E2B61F6E;
 Tue, 16 Jul 2019 15:04:30 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 16 Jul
 2019 15:04:23 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
Subject: [PATCH v2 00/17] erofs-utils: new mkfs framework
Date: Tue, 16 Jul 2019 15:04:02 +0800
Message-ID: <20190716070419.30203-1-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This is patchset v2 of new mkfs framework, decompression
inplace and compacted indexes supports are added in this
version.

The latest code can be gotten at

git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git -b dev

as well. The 1st release will be finalized after kernel
implementation has been reviewed.

Comments are welcome. :)


Thanks,
Gao Xiang


Gao Xiang (12):
  erofs-utils: introduce buffer cache
  erofs-utils: introduce inode operations
  erofs-utils: introduce generic compression framework
  erofs-utils: introduce lz4/lz4hc compression algorithm
  erofs-utils: introduce compression for regular files
  erofs-utils: propagate compressed size to its callers
  erofs-utils: add README
  erofs-utils: introduce dev_fillzero
  erofs-utils: non-inline tail-end block should be zeroed beyond EOF
  erofs-utils: introduce compacted compression indexes
  erofs-utils: support decompress in-place
  erofs-utils: introduce extented options setting

Li Guifu (5):
  erofs-utils: add erofs on-disk layout
  erofs-utils: introduce erofs-utils basic headers
  erofs-utils: introduce miscellaneous files
  erofs-utils: add input/output functions
  erofs-utils: introduce mkfs support

-- 
2.17.1

