Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 581357226AB
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 14:58:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QZYZX4FQkz3dx2
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Jun 2023 22:58:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1685969924;
	bh=Bs3nDPEBUChQxGVs6wg5auLewtUHgSHbpkhgrvzw0Ww=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=WWlxmlJZQZnBOeCNfj/DweMFB/K6znpr7I81VzcvEceqsiSkKdIUfUqS78/jMMu9p
	 brHUrjpfL/PTdTI6IdD7YqRflBaIw0S4Gq+mKuFm65tSFtZbkbG3DcSJLzs8VqtwG5
	 JBiHGEcjD0mGbsOc1v5dnfRI2FIs19ozI9CW/q+DimITVvl0JM49C37BheYS32oxhZ
	 Qar/7vZU3tXC39mRv9hKiXo1KbMXYDYTWntcMkjAApbOjxM5lgXJero0nJuwqP6MNi
	 MgrHeyxoWKXzSO3PkdDSxt3E7B+kM6r8tN5rFDAYe79awK/4FXnEgwT8Z6K5K8hcqC
	 8tM+Nt1X2r6iA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.23; helo=frasgout11.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout11.his.huawei.com (unknown [14.137.139.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QZYZT3fLQz3dx2
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Jun 2023 22:58:38 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4QZYLJ5mbQz9y4TN
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Jun 2023 20:48:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP2 (Coremail) with SMTP id BqC_BwC3wVvp231kR6FUCA--.20206S2;
	Mon, 05 Jun 2023 12:58:21 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: fix segmentation fault for file extraction
Date: Mon,  5 Jun 2023 20:58:15 +0800
Message-Id: <20230605125815.2835732-1-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: BqC_BwC3wVvp231kR6FUCA--.20206S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF1rurW8Gry7KryfAr4Dtwb_yoW8AFyrpF
	W3Kr1IyrZ2qr4jyryxKF1DtrySka4rJ3WI9ayq9a4fJw17XryDXFyIyF9Igr1xKFZ5urWI
	yayqvw15GFWDAFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l42xK82IY64kExVAv
	wVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU173ktUUUUU==
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
Cc: jack.qiu@huawei.com, yangchaoming666@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, we use fsckcfg.extract_path to record the path of file
to be extracted, when the name is too long, it will exceed the
fsckcfg.extract_path[PATH_MAX] array and segmentation fault may
occur.

Test and reproduce with the following script:
``` bash
#!/bin/bash
FSCK=`which fsck.erofs`
MKFS=`which mkfs.erofs`

IN_DIR=./src
$MKFS x.img ${IN_DIR}

get_dst_dir()
{
	local len=$1
	local perlen=$2
	local dst_dir=$(printf 'a%.0s' $(seq 1 $((perlen - 1))))
	local n=$((len / ${perlen}))
	local lastlen=$((len - perlen * n))
	local lastdir=$(printf 'a%.0s' $(seq 1 $lastlen))
	local outdir=""
	for x in `seq 1 $n`
	do
		outdir=${outdir}/${dst_dir}
	done

	[[ -n $lastdir ]] && outdir=${outdir}/${lastdir}
	echo ${outdir}
}

for n in `seq 4000 1 5000`
do
	dst_dir=$(get_dst_dir $n 255)
	echo ${#dst_dir}

	OUT_DIR="./${dst_dir}"
	rm -rf $(dirname $OUT_DIR) > /dev/null 2>&1
	mkdir -p $OUT_DIR
	$FSCK --extract=${OUT_DIR} x.img > /dev/null 2>&1
done
```

Fixes: f44043561491 ("erofs-utils: introduce fsck.erofs")
Fixes: b11f84f593f9 ("erofs-utils: fsck: convert to use erofs_iterate_dir()")
Fixes: 412c8f908132 ("erofs-utils: fsck: add --extract=X support to extract to path X")
Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 fsck/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index a0377a7..47c01d8 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -131,6 +131,11 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				while (len > 1 && optarg[len - 1] == '/')
 					len--;
 
+				if (len >= PATH_MAX) {
+					erofs_err("target directory name too long!");
+					return -ENAMETOOLONG;
+				}
+
 				fsckcfg.extract_path = malloc(PATH_MAX);
 				if (!fsckcfg.extract_path)
 					return -ENOMEM;
-- 
2.31.1

