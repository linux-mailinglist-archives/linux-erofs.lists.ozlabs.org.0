Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D1D71787E
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 09:44:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QWLr36tYYz3f5S
	for <lists+linux-erofs@lfdr.de>; Wed, 31 May 2023 17:44:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1685519060;
	bh=N2GeSa1BLDJl0UbnIfmqJThp0fxARH/Bp+9+J/8h4k0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=kCOGWjd0cDaS02IlToPQc03H+NLzebRCGGZCzopNL5AQenOQ0bH61u8USIUTrhiWX
	 W/gspOA180fJKFCtXPC3zoZfSx1RaVz77ASJ3wKf9It9ZmanhwTZMu53sXj9KhoKzW
	 Cf+TYFRNSYck9rnU2ZLLmySiOy/VA6TZPQC9audsr9ibFVZOGWs8A0jWzQD3WI3s7e
	 upMhNeS6ZMN3eWfaJr2wdarrbgSMSgRrxdTcfsEmxfCM2NU9QyD0x3wFGR0Xc+EPSN
	 wbkJZWtpx8b7yfCUfW1tFOEPl3FIVrNvosAcM+LiTyuI6TEASh5F84bvZlY0PX1GKQ
	 FM2yoUU6e/4oA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=huaweicloud.com (client-ip=14.137.139.46; helo=frasgout13.his.huawei.com; envelope-from=guoxuenan@huaweicloud.com; receiver=<UNKNOWN>)
Received: from frasgout13.his.huawei.com (unknown [14.137.139.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QWLqr2lvpz3cjY
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 17:44:06 +1000 (AEST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4QWLCy1nvBz9xrpD
	for <linux-erofs@lists.ozlabs.org>; Wed, 31 May 2023 15:16:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
	by APP1 (Coremail) with SMTP id 76C_BwDXPTGi9nZk5ngiCA--.15676S4;
	Wed, 31 May 2023 07:26:35 +0000 (GMT)
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: fsck: fix segmentfault for crafted image extract
Date: Wed, 31 May 2023 15:26:12 +0800
Message-Id: <20230531072612.2643983-3-guoxuenan@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230531072612.2643983-1-guoxuenan@huawei.com>
References: <20230531072612.2643983-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: 76C_BwDXPTGi9nZk5ngiCA--.15676S4
X-Coremail-Antispam: 1UD129KBjvdXoW7JF47ZrW8AF4DurWUWFWrGrg_yoWDtrgEva
	yIgw4kWF43CFsrZw48CrWvqrWj9r4xCw4xCFn5XFW5XryDJr15Zrs7XasxCF4xCFWv9asr
	CrnxWrn3Xr1UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbf8YFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r15M2
	8IrcIa0xkI8VCY1x0267AKxVW8JVW5JwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK
	021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j
	6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7V
	C0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j
	6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxAIw28IcVAKzI0EY4vE52x082
	I5MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8rb15UUUUU==
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

In crafted erofs image, extract files may lead to fsck.erofs
memory access out of bounds.
Actually, there is already interception in the code, but which only
take effect in debug mode, change it to avoid that.

Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
---
 lib/decompress.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/lib/decompress.c b/lib/decompress.c
index 8d1b25d..59a9ca0 100644
--- a/lib/decompress.c
+++ b/lib/decompress.c
@@ -138,8 +138,12 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 		if (rq->inputsize > erofs_blksiz())
 			return -EFSCORRUPTED;
 
-		DBG_BUGON(rq->decodedlength > erofs_blksiz());
-		DBG_BUGON(rq->decodedlength < rq->decodedskip);
+		if (rq->decodedlength > erofs_blksiz())
+			return -EFSCORRUPTED;
+
+		if (rq->decodedlength < rq->decodedskip)
+			return -EFSCORRUPTED;
+
 		count = rq->decodedlength - rq->decodedskip;
 		skip = erofs_blkoff(rq->interlaced_offset + rq->decodedskip);
 		rightpart = min(erofs_blksiz() - skip, count);
-- 
2.31.1

