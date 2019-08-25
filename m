Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD549C16C
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2019 05:37:20 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46GLRd2Db5zDqT4
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Aug 2019 13:37:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1566704237;
	bh=98NUpfNV0+jAleEtM/En36tw4xUfVhaJNXJpRI3firk=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=nAfAxFnS99DNedwAj0x2E2WjTgBNmh3fn6TWRx4mzGAkxcu+7N4guF5kH3SkvAow5
	 ydd98/wfpVq2P8S1/b9KOv2Rx1dvd5LwS6Z1sb7CFqI4Po0BVN5PxCpJc/EfkYFLEW
	 0s0suIimWZx8dstj4QAms1qyUJFnTtiCEfUcrVRYSd16FPTt5xFJELUBUGrYCKXX1c
	 emQSlU5jZsWK0YR8Lon3jGGYGS3Kb3WaCRRC2TXieOhl525c+m7OSIQ4xYmHA1lgMH
	 CWoaVanOESIO6q8PGpG2YxBjzkIUXmGTkFWswwO7blr4ba+EFlT6Vzlu2mun0oVcOa
	 g11f3YPUZqLNg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=77.238.177.83; helo=sonic305-21.consmr.mail.ir2.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="igZwSWjp"; 
 dkim-atps=neutral
Received: from sonic305-21.consmr.mail.ir2.yahoo.com
 (sonic305-21.consmr.mail.ir2.yahoo.com [77.238.177.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46GLRS1zkfzDqBM
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Aug 2019 13:37:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1566704218; bh=tyooHBbeG+FE72kzgcq3VIPHcgEKbl3YuuyOq+5NRc0=;
 h=From:To:Cc:Subject:Date:From:Subject;
 b=igZwSWjpLuNNDS18g+RW7GTV3X7XKImIqcv3fdSCL5ziWZ9Dseo+UEqvfw/BEZGbMarMa9HeUNhrUuvpt6e/WLSOnhPXJJY7hJLGQJvFrxsrozlRuKO/eqpgdlNLJT3GesVWuFFw7XWXzquNbQpD8JbXDRifJOqymUZb7D4P4l5C2i0nDVWjETABu2RvfixXqNbZOg3mzP78Xchu/TkpT5GsFzDCeUJi87gqsqK9CLDTKb0QEy6Ro6koxBykF7M30Qpft+/z3bGmI5fmQku55k+SglYurjhEigiakWOwHM4/42rNo1g0K9Ay7w+2l7zGj0FPX1QigLj5KWlIWlFqHA==
X-YMail-OSG: tpCU3z4VM1nMoX6yCrCFFcRt_uezSiwCwyQOGIbVAupjwocjulMusBUgllmb9YB
 ZpdZev2O92k8GlGVr.yd8UnAKPGL_CRWjbo6IwTpzsU1iCOF.OAC7OD5r8.QsxO0w310og1ux7rO
 X5eEogMaPuEBc61vxj4xyK4GAppqa7Px9Fw8C8FBr8.UQd.LiZBDvZxwrR9tQUdOLt2vniBv7qrw
 MRuywePrTMBdn_8z23_DM2Wnt7MlUsy1yoMxwfC39waG41DmqNu27r2FJhJqB3TCrn_MgXQ_cjEO
 9Y.Yyr8YyeqA.Ljh2SLm.LXIiGd35E7nQIfFXTscI4Ve4B8W.4_Jqu4KZhko5_W3knoMAd.5ioVN
 FgqnEcC..uFILwml7gt4cqsyjuCMx0J9FdN6R4KljJsSCSpiH8hGGAmjYZdV6PDbxs0qXNokUiU5
 t3QjpeIFxxn7wJJbgSmW3Yb52Lrs1VdRewOp68DFK1yEqHCFBzWuNqlLaQBRNBbROfzjH6MYLNkl
 QdjCXH8_SKs7WX2W5_VbjKIoHeyfNNev6aliJbf8gLwiUWNc6J5XT.vkNY3hgXCBvjyJEt9UYp0O
 wD0lKJw7E339DIdG4WI3EmxRyB_j7oBd7iOvAmXNjz22lI2rJvocS5Nmi0tEFn_C9E8WxW4mYlrV
 rAJGWpIiCd2cbo4LxrBp3SRamlLfMxqpPLM2Ss.f5fQKtHk9WFmiphcIjfDPB0WTwyDydbGsJcW0
 VCIMqnkZEPsFxjup40h2aypcZKPfJ0Kz4n4fY29IMmL.OfiQuIi5JR9Pj4wWy.9SActhUnH41PWM
 PxdLp3XTyMIg7jiL_wA2cd1ocdKwNiPXq06EtHtUNME7R1J9S7gwuSp_27vJhm_bjrrg6j1Ex5A1
 n6x9zo1JG6OISAoNIE8_.Tcmpqyy8JxMVqYA_4uhWJroPdl2LASXBUmm6xpCPFMLyX4gD.yj_WZG
 mBj7dC_oF4FRy8HtOYYnTUQ_3nC2HQPxy0pv3wjemQNnh_PTM___uMgTPBI0UK9lOWn26SzsATuy
 SDvfJu2NVOERch6.uCyrxlYL8IECuh8fFxDPl1sHRk8B230YaWjimB4I_b55QUPlL31xJFv_oTx_
 ..yBMkSnIyY4n6Zr8vuXgatOvUEYNjHM7mMwxhh_quB9uKiVGZRqB.AD79.5OJ8h8Xp1UFJxyGuv
 fmCEFMdBIiP6AzJmcPmqAQVXAVqfIslECY5Ali2eOn6RkVsqDxdhQAsX9chIcSbtimScXHH9a_cW
 bXhjxZyfXvMu71l1HoM967bI9mMD0
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.ir2.yahoo.com with HTTP; Sun, 25 Aug 2019 03:36:58 +0000
Received: by smtp407.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 8fa19eca88da82cb18ac35634671fd90; 
 Sun, 25 Aug 2019 03:36:54 +0000 (UTC)
To: bluce.liguifu@huawei.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix a memory leak of compressmeta
Date: Sun, 25 Aug 2019 11:36:38 +0800
Message-Id: <20190825033638.30216-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

compressmeta should be freed after successfully written.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lib/inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/inode.c b/lib/inode.c
index 581f263..141a300 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -404,6 +404,7 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 		ret = dev_write(inode->compressmeta, off, inode->extent_isize);
 		if (ret)
 			return false;
+		free(inode->compressmeta);
 	}
 
 	inode->bh = NULL;
-- 
2.17.1

