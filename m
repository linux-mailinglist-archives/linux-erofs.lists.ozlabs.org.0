Return-Path: <linux-erofs+bounces-1562-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C64CD8B73
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 11:06:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db9d10ynhz2yFW;
	Tue, 23 Dec 2025 21:05:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.221
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766484357;
	cv=none; b=XuV/qOzIPojA7ScMPrC1euy7cGvVHhLEVoyFRXma4rFzGGQQF0nY2xD2AqD0kgRmivWQ6OILtmeNd/rUVQkcsQL3zNrTVasN/KlfaHrSj61EnATgOyNANkp7OMqnBPMraujnYGQGTloz3rCqiKtHHvn1adbCil8l51+4VphR+r6hN2CWD73FjeNnsPSBYCuz4dQPJdtus5drQP1m9qp+Wb/IpVqrj2zHdC7znPPs7F0MH1MwVeETYlW/nki//h6HYURk6aKHH4ahB8CVO8GoxMb8XXTRfNRzso8GuzWPrFgf73RT2ZZ9CSeBQo6iWlxginxhXv5t4TJbzBmjTRDapw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766484357; c=relaxed/relaxed;
	bh=WFuNpb3+fgZ5ZvCZ8ijiTpmzk1TpgTF6uxHNGhljDrE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IABNWn6knv2DRs4VXaKghnKuYqxDr4t3UkzpIkYhJReYsEvsJk9SFrFJo/MhxfsryL/t6d2E1C5rvo45tUe2FM8v2LhO+UO78DVfyObDzyctV7foXFnRqsEfNkGeobjMRRHha8cj/QGFKskeNwaSULo41Qi2SfwrTGyL/hVyb++u24GUEjI2jF/i2+WaJUsNqBt2fCKjcmsWcEKgD+vJJRvrr2koV97X5ciSV2hQgM/wFeEWvop7gYznYwF3ppARBqxTiHgrkOx8qTws3O269440Qkh4UNkHoTnTDWV25asC9+uDWinok5W/icmZKbI7MNNYDNHUHWGaG67CJYZmHw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NFQJnZD7; dkim-atps=neutral; spf=pass (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=NFQJnZD7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.221; helo=canpmsgout06.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db9d028xvz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 21:05:56 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=WFuNpb3+fgZ5ZvCZ8ijiTpmzk1TpgTF6uxHNGhljDrE=;
	b=NFQJnZD7mca4V7dmwrPyow9V/dWTJ87srEb18bV41ofhayq09NhebmGx8wZfNQCcZ57RW1qw1
	VsYgVs27AFxlF4klERVumh9PR58cu88Db5vlkGdQpiqvD6jjiBVy52DZoaa7TzB0ftvx/yT5uV0
	ViEg9cgzkpNOcPknpOoRJkA=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4db9YK4KRPzRhRm
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:02:45 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 4C92040567
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 18:05:52 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 23 Dec
 2025 18:05:51 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>
CC: <jingrui@huawei.com>, <wayne.ma@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 4/5] erofs-utils: mount: gracefully exit when `erofsmount_nbd()` encounts an error
Date: Tue, 23 Dec 2025 18:04:51 +0800
Message-ID: <20251223100452.229684-3-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251223100452.229684-1-zhaoyifan28@huawei.com>
References: <20251223100452.229684-1-zhaoyifan28@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

If the main process of `erofsmount_nbd()` encounters an error after the
nbd device has been successfully set up, it fails to disconnect it
before exiting, resulting in the subprocess not being cleaned up and
keeping its connection with NBD device.

This patch resolves the issue by disconnecting NBD device before exiting
on error.

Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
Note:
- I believe directly killing the child process is unsafe, as it may leave
in-flight NBD requests from the kernel unhandled, causing soft lockup.
- And I believe using nbdpath here is safe, as the child process maintains
the NBD device connection throughout, preventing concurrent access by other
actors.

 mount/main.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index 2a21979..d2d4815 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1287,10 +1287,23 @@ static int erofsmount_nbd(struct erofs_nbd_source *source,
 
 	if (!err) {
 		err = mount(nbdpath, mountpoint, fstype, flags, options);
-		if (err < 0)
+		if (err < 0) {
 			err = -errno;
+			if (msg.is_netlink) {
+				erofs_nbd_nl_disconnect(msg.nbdnum);
+			} else {
+				int nbdfd;
+
+				nbdfd = open(nbdpath, O_RDWR);
+				if (nbdfd > 0) {
+					erofs_nbd_disconnect(nbdfd);
+					close(nbdfd);
+				}
+			}
+			return err;
+		}
 
-		if (!err && msg.is_netlink) {
+		if (msg.is_netlink) {
 			id = erofs_nbd_get_identifier(msg.nbdnum);
 
 			err = IS_ERR(id) ? PTR_ERR(id) :
-- 
2.43.0


