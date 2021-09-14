Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE7E40A50C
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 06:00:12 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7qPQ2j0Sz2yPv
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 14:00:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DHDb3Rz5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535;
 helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=DHDb3Rz5; dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H7qPL1KMVz2yJr
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 14:00:05 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id n18so11433568pgm.12
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 21:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5qEHypaye/z+CPwffHX2cbHJQDnbTYbtllX3pG1q5k8=;
 b=DHDb3Rz5pFlUo5E6TMp1W2d3w+57XdjU6kNZYgn/XsKV8uTgx9+U4RbAn7PhDGe72j
 VUoBS9Gw75XEkCoT7VfBjbOurpq86+A61KCRBy6q0G3acgmHE9fpa7IHz6vQUioQi8TQ
 AosHKyBrbUeSk1jDTpMYQf0YA/KKCT4UuYv04FKA/Bufra+KN1vrj0DMlQzxVFLwFn+D
 0iPdT9dXlFVodLsdN5zzozfhZSYq06d+DeGWN+KdStiZrhVOx1WLYLF7X1vkZ3LWyFsD
 d2dleXz379uY04BdbD4NUfYgluT80XSkrGshfkEZnP9b8W6ctXBbJnbLp65wUcxvkJk9
 Xq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5qEHypaye/z+CPwffHX2cbHJQDnbTYbtllX3pG1q5k8=;
 b=TnPTKjTMTrxj9gDDVARyWs6faIBAv+ue0mHoEYye7nB5vafoAcdJrxvM3VhNVOO0T+
 kbtn/KqzuEll0KsgUJq+CGa87hFrznCP6XqwTdK/dVMAy4m6O2v5KlaCW7YhTtm/W9eQ
 Uci3dQKpodluD6KXbRkFUJXoWeLE2TI4495OKIKXubBrFIJIZ6BJWkEuNvXCzbp1OG/p
 8pRLGn2BTlW4PsQvtVtHBhZ773tREsTy8YkUzDOHnK370dQU6u+Ax06USS8F+/oJQ/kV
 gI7VDx6gfh87QC18LW1vUYUEAY0Vt1zDU0/19O534r5srq6Oqb++g0RoY3cNdo6ui/us
 oTow==
X-Gm-Message-State: AOAM531s2dUl0xvU4Onss6lzrGjys6ovkcIvQb44Dz5FD0OAM5wWwphb
 5+6FPuYL3YzxG/cHUimsGCQ=
X-Google-Smtp-Source: ABdhPJwA/1DQWM2pwsnw8lpZOR8vjdeWexZi0opfjU/AZ0DKkZr34MK8Fm9YI/mCO+k8cYHt4cEmzA==
X-Received: by 2002:a05:6a00:1150:b0:40a:78df:8179 with SMTP id
 b16-20020a056a00115000b0040a78df8179mr2674364pfm.67.1631592001864; 
 Mon, 13 Sep 2021 21:00:01 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id d3sm8478994pjc.49.2021.09.13.20.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 21:00:01 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: fix compacted_2b if compacted_4b_initial > totalidx
Date: Tue, 14 Sep 2021 11:59:15 +0800
Message-Id: <20210914035915.1190-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zhangwen@yulong.com, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

Currently, the whole indexes will only be compacted 4B if
compacted_4b_initial > totalidx. So, the calculated compacted_2b
is worthless for that case. It may waste CPU resources.

No need to update compacted_4b_initial as mkfs since it's used to
fulfill the alignment of the 1st compacted_2b pack and would handle
the case above.

We also need to clarify compacted_4b_end here. It's used for the
last lclusters which aren't fitted in the previous compacted_2b
packs.

Some messages are from Xiang.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/zmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9fb98d8..aeed404 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	if (compacted_4b_initial == 32 / 4)
 		compacted_4b_initial = 0;
 
-	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
+	    compacted_4b_initial <= totalidx) {
 		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
 	else
 		compacted_2b = 0;
-- 
1.9.1

