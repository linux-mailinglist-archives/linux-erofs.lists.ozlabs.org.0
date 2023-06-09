Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC4D7293A8
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 10:51:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qcvv22YYYz3f15
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Jun 2023 18:51:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1686300670;
	bh=uiSCPGAkCtXchkEomcwCcpEbLOb5PrclY+Yl1sl8kPY=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=gizvMno65FEHy8WK+xZ+n3wKkcDI5Cn1uwtO9K9XcYgL/h9chD5CgGrY5Krj3IT+7
	 eVVZEdKsk/rLad2lklxM+A+iOMJp7C/CdsCrkRgtDTpBGEqoH+KAVeW2097hSyzt3K
	 aBWe4Yp7m6uMLDMPVEYroNaM9GQqmL6uqLMbnVWJJbRlk5rAydsON9HmRJINnrxq/U
	 YDxs9ClweUr8bUE5GwWhGX3zFNBDa+4PUx4ge5oJ/Bz06MNAga/Vv/fHaO9NtU8s1C
	 IzvDCuUkNrMSxSLyAxqqxZzt8liXZJJUqITx3C4Xn/KOXiX7j1nUxNv7YHyHDGRkKH
	 KSQ0DNx04JohQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qcvtt049Pz3dqq
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 18:50:59 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qcvfd1jvwz9xHvp
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Jun 2023 16:40:25 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwD3GnXj54Jk9pqGCA--.24524S2;
	Fri, 09 Jun 2023 08:50:47 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 0/4] erofs-utils: code-refactoring for erofs compressor 
Date: Fri,  9 Jun 2023 16:50:37 +0800
Message-Id: <20230609085041.14987-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwD3GnXj54Jk9pqGCA--.24524S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4fGr47XFyUJw4fKrW5trb_yoW3Grg_JF
	yxXFWkJr45XFWSgFWfGr4vyFWUZFW8tF1UZF1qqw4UAry2qw45Gr4DJa15Ww1DuF4Ykw47
	tFnxJrykJr9rGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267
	AKxVWUJVW8JwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
	ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE
	52x082I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UEg4hUUUUU=
X-CM-SenderInfo: xjxr53hhqd0q5kxd4v5lfo033gof0z/
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
From: Guo Xuenan via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Guo Xuenan <guoxuenan@huawei.com>
Cc: jack.qiu@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

simplify and unify erofs compressor code.

Guo Xuenan (4):
  erofs-utils: lib: refactor erofs compressors init
  erofs-utils: lib: unify all identical compressor print function
  erofs-utils: simplify erofs compressor init and exit
  erofs-utils: dump: add some superblock fields

 dump/main.c              |  11 +++
 fsck/main.c              |  15 +---
 include/erofs/compress.h |   4 +-
 include/erofs/internal.h |   1 +
 lib/compress.c           |  81 +++++++------------
 lib/compressor.c         | 169 +++++++++++++++++++++++++++++----------
 lib/compressor.h         |  24 ++++--
 lib/compressor_liblzma.c |   8 +-
 lib/compressor_lz4.c     |   8 +-
 lib/compressor_lz4hc.c   |   9 ++-
 lib/super.c              |   5 ++
 mkfs/main.c              |  16 +---
 12 files changed, 213 insertions(+), 138 deletions(-)

-- 
2.31.1

