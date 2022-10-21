Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CA6072DA
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 10:49:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtynW4wwGz3drV
	for <lists+linux-erofs@lfdr.de>; Fri, 21 Oct 2022 19:49:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtynT0xfTz2xG7
	for <linux-erofs@lists.ozlabs.org>; Fri, 21 Oct 2022 19:49:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VSimdbh_1666342152;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VSimdbh_1666342152)
          by smtp.aliyun-inc.com;
          Fri, 21 Oct 2022 16:49:13 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com,
	xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/2] netfs,erofs: reuse netfs_put_subrequest() and
Date: Fri, 21 Oct 2022 16:49:10 +0800
Message-Id: <20221021084912.61468-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: linux-fsdevel@vger.kernel.org, jlayton@kernel.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The data routine of erofs in fscache mode also relies on
netfs_io_request and netfs_io_subrequest.  erofs itself maintains a
copy of some helpers on netfs_io_request and netfs_io_subrequest.

To clean up the code, export netfs_put_subrequest() and
netfs_rreq_completed().


Jingbo Xu (2):
  netfs: export helpers for request and subrequest
  erofs: use netfs helpers manipulating request and subrequest

 fs/erofs/fscache.c    | 47 +++++++++----------------------------------
 fs/netfs/io.c         |  3 ++-
 fs/netfs/objects.c    |  1 +
 include/linux/netfs.h |  2 ++
 4 files changed, 15 insertions(+), 38 deletions(-)

-- 
2.19.1.6.gb485710b

