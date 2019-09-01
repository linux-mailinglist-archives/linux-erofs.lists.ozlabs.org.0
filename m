Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id CC655A47A0
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 07:52:34 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Lj6R3P0TzDqtY
	for <lists+linux-erofs@lfdr.de>; Sun,  1 Sep 2019 15:52:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1567317151;
	bh=jUpuO5pbz6bQ5IgeNxX/6TzOKdiQgFbuGns7Wm4QJgQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=N6t8BwgpZosWbHDS/Ihd4VOGRzJtF5xFXHQzSUi7Pd25zYa2r2y/e9vuqQiHqEfal
	 S8UrNf/oMrqqJ7wBxTTnf/ssSsYJofyAvHQQej95IX6TIBi2zSjGnCwWnC6iSd8BzV
	 ky/WwJmm/R2Jzklg+/xLJTyK8lPHjqz9BzOEFPfwayWb1j+4qFgmGRGqNwgL+Azab8
	 7yy1m+IbweRsyNGICqeX6uY98fCEyiIFWs3YVIHuOJNGMIq/XxiLwAfv8Uiy2z1jXT
	 VYlzYwq5MTR8fzjgZTQTWDFAfrjzOdbph0Y6WKWvDF+15sgw1pOoEREHuCsOvSHFyF
	 RJDz4XgmprNNw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.32; helo=sonic308-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="ZyUeUQC0"; 
 dkim-atps=neutral
Received: from sonic308-8.consmr.mail.gq1.yahoo.com
 (sonic308-8.consmr.mail.gq1.yahoo.com [98.137.68.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Lj666hqBzDqvr
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 Sep 2019 15:52:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1567317128; bh=mTmwRZ2g3QljgC6KiLAN+Ium+nqdfr+3BykXX0EI6eU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=ZyUeUQC0NOatgpXuDLF3rpRK0jy0LMQVptNi4Q3921UQXFxNNXXTbwrVpwba2MqsR2DH4holji1R779hXFyaBdI0Pz+9VxwGvgx4p2dvupgwxIwbibAwz67xYAManSJc4zSxwENuRpCf4tUlkrR/eAVWADAhNKDh13/s2Soj8ZqBIff0aZSDv20otJCOUi6cjOLCUQM+7K3XwDzv8Eoi6IAP4Z/D9tocCHSUCHMW1hSScAqvX+Uw39lxmfN0/oAySr87Ee9TlltICNZtGHsoERpvo+lqlQtiNCBfjxlSNsgznev3pg7pwob/BcSc98cFUlgviqqS6svbu9PSDCfjSQ==
X-YMail-OSG: s56rVUIVM1mwzoUf8WsYDID12PeGeY4vZEh_RrWN6n2uXOvIz3qaIX4y0xL1yS4
 RfINvJCRlH21f3NIrnlKVDFEGqd0PlR.IEBOTdtLwxCL42cNPjfxt_qBgkM8V46Pq3L54YsSjLpE
 O35MtuwLRQzDYvvnUlZP2slwSB.68tdazJLXonhte_YNyV3sAUC9HTYt5UvHoiYbWEn4PJG1Pwp9
 Nk5OMqyO7xXvgt7M1OPmI9OCw4jS7sSsATFxSsFYyL9MGWctKZIRcxJftNg3nJiDjwTRZh8A6HOj
 qyj9v4tiwmP5rSuALFreKiUf_Od4m06aRx6BP24GCgim9PGHpBjV1FEVgajDgvDVA9MsxBH48jzm
 N8jhoTbtAj5Qsvqqt6LNRPC0ojf4nFZfAnN0u1j1OMjL.U8fpEx5q8M7Yba4YhuhnKMX_isN4K4n
 30_T26_iAdpXRMYo33FtFz3wodMNN8hKRhw0SMG_m2jmwYS6iF13ZN__y_EW9IRNTh9FSn0dj17i
 9NRmHrC0CP4i.GLOgxdhOfMyx0Y.iDWQ.c6lpIJVlTfRSlyxtuGZQ5VS6Jh0fKJnT70yiUM8kSih
 865nAsZzYojzEqn_Q2To8yNjCiZRLbiU8UEu5zSc2kyd26Acsz.jlI.C.pS1tFaHXUr4cTpV_m67
 wk0D0pwzQT.VpYDghMaM3QrwUV3yVcZxW5evmTju496rmPdLa1SPif1JxDXP8YLmSaqzABX5eAW7
 VBFKn9xLeEDB5mBT63L..rNwW_ytnMYVXT5OcmZ8V9Icfaid3DWK.cIHdjJYBd2eHQTfePlfqHja
 F3u698bNfIZLLtuHcsgdX9izTv6kKBvRxOnoHkOgmAjh2q4kqM6HgR4VImdsBbPios39.vtNaTUs
 yGKpgDQo5nZ9LuES8MMNti8MBzXI0oK44yy_l.SfQG0DPqAUT5BOjqvo4GcREbLjtqAjRRloY6xw
 24O0iADcwJTXo2lrP2SCHK8cUPl7VTtkN4qvRRa6xIVP4umNcJdkvliAIxMhILx.iAm0QlOOCyUT
 L8NvrzgBn2A6CNG70JWk0ZPt4VPf5OpaLDSKdRILQD7QhvmelUlWVxg_taI4qBy2oxqZSjxUffwe
 Ps2CQeUO_cVJDraqZqbt1E2sIky2VmfYVy2eKqr5OtQzUMuGjYKRm4lpNf5KK4OJZYq9N1H0v4.z
 Xu2N8BgWkRQGK3MQw.ucIXBV4N_gsPWoJnKjMzRpZMRX053d9zii6DlZF09YEChSsngGSd1JsZhm
 heDixjuoz2XD68iQNtjtXcoWL9usCx2_XAvZcKQs-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic308.consmr.mail.gq1.yahoo.com with HTTP; Sun, 1 Sep 2019 05:52:08 +0000
Received: by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 426e3b5ec1af9e36f409445c51071a70; 
 Sun, 01 Sep 2019 05:52:07 +0000 (UTC)
To: Christoph Hellwig <hch@infradead.org>, Chao Yu <yuchao0@huawei.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 04/21] erofs: kill __packed for on-disk structures
Date: Sun,  1 Sep 2019 13:51:13 +0800
Message-Id: <20190901055130.30572-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190901055130.30572-1-hsiangkao@aol.com>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
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
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <gaoxiang25@huawei.com>

As Christoph suggested "Please don't add __packed" [1],
remove all __packed except struct erofs_dirent here.

Note that all on-disk fields except struct erofs_dirent
(12 bytes with a 8-byte nid) in EROFS are naturally aligned.

[1] https://lore.kernel.org/r/20190829095954.GB20598@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 fs/erofs/erofs_fs.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index c1220b0f26e0..59dcc2e8cb02 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -38,7 +38,7 @@ struct erofs_super_block {
 	__le32 requirements;    /* (aka. feature_incompat) */
 
 	__u8 reserved2[44];
-} __packed;
+};
 
 /*
  * erofs inode data mapping:
@@ -91,12 +91,12 @@ struct erofs_inode_v1 {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
-	} i_u __packed;
+	} i_u;
 	__le32 i_ino;           /* only used for 32-bit stat compatibility */
 	__le16 i_uid;
 	__le16 i_gid;
 	__le32 i_reserved2;
-} __packed;
+};
 
 /* 32 bytes on-disk inode */
 #define EROFS_INODE_LAYOUT_V1   0
@@ -119,7 +119,7 @@ struct erofs_inode_v2 {
 
 		/* for device files, used to indicate old/new device # */
 		__le32 rdev;
-	} i_u __packed;
+	} i_u;
 
 	/* only used for 32-bit stat compatibility */
 	__le32 i_ino;
@@ -130,7 +130,7 @@ struct erofs_inode_v2 {
 	__le32 i_ctime_nsec;
 	__le32 i_nlink;
 	__u8   i_reserved2[16];
-} __packed;
+};
 
 #define EROFS_MAX_SHARED_XATTRS         (128)
 /* h_shared_count between 129 ... 255 are special # */
@@ -152,7 +152,7 @@ struct erofs_xattr_ibody_header {
 	__u8   h_shared_count;
 	__u8   h_reserved2[7];
 	__le32 h_shared_xattrs[0];      /* shared xattr id array */
-} __packed;
+};
 
 /* Name indexes */
 #define EROFS_XATTR_INDEX_USER              1
@@ -169,7 +169,7 @@ struct erofs_xattr_entry {
 	__le16 e_value_size;    /* size of attribute value */
 	/* followed by e_name and e_value */
 	char   e_name[0];       /* attribute name */
-} __packed;
+};
 
 static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
 {
@@ -273,8 +273,8 @@ struct z_erofs_vle_decompressed_index {
 		 * [1] - pointing to the tail cluster
 		 */
 		__le16 delta[2];
-	} di_u __packed;
-} __packed;
+	} di_u;
+};
 
 #define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
 	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
-- 
2.17.1

