Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4A37822B3
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 06:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1692591475;
	bh=aZtb6/hjU2BdSA8KljF8sfZgH6XHxskVovigP8D0mrI=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=LcVKe+QZ7ntHgB9J75Rowi3dJ0mAwYai2iw0imI8HyKMi0v92V1RqVFlULCXWFY8N
	 i5TqriXyycBAClZZtbehnvOhEh8Ksk5DMaTe+Cy386cNKngimQZ1RcK6LjiCBbKEUK
	 b3bjLnGu98jxLFS+9gKS3HANIdemaXr+Bmt/Uz1dqw5KSadbpoFbmqDthEB1thwe0p
	 bAwaMa2tMWRjVmU9AT8P3F5iLEozbTi9KB5FUeghkZfaBRTvz3LfKxYTI49epba1zA
	 ghdJjTChaoFVyfXH3QKLjoUPMJacHe73GPk6jWBDU28p9YxM7du0EudExt3D8XA1fY
	 e1s8W6dkseP4w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RTfN35Zxxz30Jy
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Aug 2023 14:17:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=118.143.206.88; helo=outboundhk.mxmail.xiaomi.com; envelope-from=sunshijie@xiaomi.com; receiver=lists.ozlabs.org)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [118.143.206.88])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RTfN00NYtz2yVc
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Aug 2023 14:17:48 +1000 (AEST)
X-IronPort-AV: E=Sophos;i="6.01,189,1684771200"; 
   d="scan'208";a="63057912"
To: <xiang@kernel.org>, <chao@kernel.org>, <huyue2@coolpad.com>,
	<jefflexu@linux.alibaba.com>
Subject: [v2] erofs: don't warn dedupe and fragments features anymore
Date: Mon, 21 Aug 2023 12:17:37 +0800
Message-ID: <20230821041737.2673401-1-sunshijie@xiaomi.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [10.237.8.11]
X-ClientProxiedBy: BJ-MBX08.mioffice.cn (10.237.8.128) To BJ-MBX18.mioffice.cn
 (10.237.8.138)
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
From: sunshijie via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: sunshijie <sunshijie@xiaomi.com>
Cc: sunshijie <sunshijie@xiaomi.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The `dedupe` and `fragments` features have been merged for a year.  They ar=
e
mostly stable now.

Signed-off-by: sunshijie <sunshijie@xiaomi.com>
---
 fs/erofs/super.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 566f68ddf..075d476a4 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -420,10 +420,6 @@ static int erofs_read_superblock(struct super_block *s=
b)

        if (erofs_is_fscache_mode(sb))
                erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read f=
eature in use. Use at your own risk!");
-       if (erofs_sb_has_fragments(sbi))
-               erofs_info(sb, "EXPERIMENTAL compressed fragments feature i=
n use. Use at your own risk!");
-       if (erofs_sb_has_dedupe(sbi))
-               erofs_info(sb, "EXPERIMENTAL global deduplication feature i=
n use. Use at your own risk!");
 out:
        erofs_put_metabuf(&buf);
        return ret;
--
2.41.0

#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#
