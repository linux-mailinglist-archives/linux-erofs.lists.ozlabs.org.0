Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1658B75DD2B
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 17:21:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1690039275;
	bh=Uv92lSH8NXPxoXSObaGBQFvpjD0BuD+65PUdiCuPIbo=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=QL2x2IZJCkJVqEkirCQBnobXpNRELzKmbxDYkdvzRmZdMdELnTZDvB0/x9eQLkem9
	 h10CETH78DkOCmwJpArMR3motWgT/F2fdkvPqxKxhiZSujyZ9qdrAP3PHuFytY14wq
	 kv7I4ZB6+3HVtxrpO2V7Fo2aZb5tBk0h8+JEnJmUqCy2It2a6v6nCQMgcMFQzdNFpw
	 hNtZwZG5Vn5wj0s2DSHQXbQYFYycOt/nya5nnnN9ZF5Fc909Z12mwOGQdZbNkDda9K
	 e1BJLIkPygyyB1E9O7/CdfKq9IV6l/VkdscBM8W1g2YJ/j6MM/5qZNsM2H3cqaNkjd
	 Wg5OaYyuEyW3g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7VWG71Bbz2yW5
	for <lists+linux-erofs@lfdr.de>; Sun, 23 Jul 2023 01:21:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.154; helo=frasgout12.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=lists.ozlabs.org)
Received: from frasgout12.his.huawei.com (unknown [14.137.139.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7VVw0psDz2ypx
	for <linux-erofs@lists.ozlabs.org>; Sun, 23 Jul 2023 01:20:53 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4R7Ts51bGPz9v7Y8
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 22:51:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwCXnVcE8LtkMMq2Cg--.24810S2;
	Sat, 22 Jul 2023 15:04:40 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 0/4] erofs-utils: code-refactoring for erofs compressor
Date: Sat, 22 Jul 2023 23:04:30 +0800
Message-Id: <20230722150434.2921381-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwCXnVcE8LtkMMq2Cg--.24810S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr43AFyrKFWxZr47GrWDtwb_yoW3uwb_JF
	yxXFWkJr45WFWSgFW3Cr4vyFWUZFWxtF1UJF1qqw4UAry2qw45Gr4DJw45Ww1kuFWYgw47
	KrnxJr95Jr9rCjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
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

erofs-utils: code-refactoring for erofs compressor

Guo Xuenan (4):
  erofs-utils: lib: refactor erofs compressors init
  erofs-utils: lib: unify all identical compressor print function
  erofs-utils: simplify erofs compressor init and exit
  erofs-utils: dump: add some superblock fields

 dump/main.c                 |  13 +++
 fsck/main.c                 |  17 +---
 include/erofs/compress.h    |   6 +-
 include/erofs/internal.h    |   1 +
 lib/compress.c              | 114 ++++++++++++------------
 lib/compressor.c            | 169 +++++++++++++++++++++++-------------
 lib/compressor.h            |  21 ++---
 lib/compressor_deflate.c    |   7 +-
 lib/compressor_libdeflate.c |   2 -
 lib/compressor_liblzma.c    |   4 -
 lib/compressor_lz4.c        |   1 -
 lib/compressor_lz4hc.c      |   3 -
 lib/super.c                 |   6 +-
 mkfs/main.c                 |  18 +---
 14 files changed, 205 insertions(+), 177 deletions(-)

-- 
2.34.3

