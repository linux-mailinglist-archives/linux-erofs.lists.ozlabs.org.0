Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B40C1744F5
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 05:51:57 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48TvBy5pH2zDrMW
	for <lists+linux-erofs@lfdr.de>; Sat, 29 Feb 2020 15:51:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1582951914;
	bh=1H1lVr+jhfUZRIpIu9vdgnD7z8K8XoITbiqRxcyjWWE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=AY7KnBTZa1mzjKil6husvtFT1rgGWf4Z+5FYIGtrxWNQMUPJ4tILGxNzW4ScSo4IX
	 QJWQIxwy+VZKKaVKtU5Iale48NAJ0TFBdm+bsCP3EEAs8WIZwvIEFOwhNQmEJhuF5s
	 8sqSp2NBu5/V+5luJs0KcT1oHLa6Z72u3/XJKRhbHpX4+l27dBSrtOyuK2LrG1l6P0
	 Q3s3TbVVJyrA0LMtpT0CYfXOgovjuWhk2w2jQb4peU+GXx3tGxlXnfAzyDM6+ikc3j
	 peN1g2iLOSdS6x4iaOkP6olVGrL+hPclYd1pOqiOHEk7UPJbbmbdb/+ustnfpW53KY
	 l5QR72UtAX+wA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.66.147; helo=sonic317-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=JwzIPS10; dkim-atps=neutral
Received: from sonic317-21.consmr.mail.gq1.yahoo.com
 (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48TvBd0tj7zDr6X
 for <linux-erofs@lists.ozlabs.org>; Sat, 29 Feb 2020 15:51:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1582951893; bh=z44WZJoxVdGc+2g6xYQ0xv1oz4wAw+thFpSjM5mmNag=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=JwzIPS10mEhWqegAK4sCdl+WFqlnAgArc8n+4OTtTtCh61EUWc5O2wF5LEcweATuyRGRzuGA+RjXz10EjlipZSVWKhm759Gjx/Kr746pJNL7+kOapShHkgLsRg3pJCJ8DqJWo8q7vpXIJdLD3BVh06wcZwrdf9m1C6lF+b76ZuZo2+R7l5c4gKL0TFD4BgypZ+IE856RhIZNd0vc5BW03MUCwVPf4kgiNG6In8dDcj06zWSHIFaen2if9Eb6atSyEBDc2k/uZSrj+7DzUu+eN/uAa2bHiQODFFY/LwM5lHVShJJfFWPmbTkImOsnERsVe/K1AR14/JSJa6CI5M0otg==
X-YMail-OSG: Lmb8GOwVM1k6rkh4gDdIGCDzNJKhAWtn5y.j9A9PXI4kBp7cowU.3m3Z6Mu9ArD
 D59sKtn.qTSuuQ2pqU9pubkyzGvLSfDxZqWr61Kdy5ed23kRRuJik_Fo8OmUjRKFIqqrsDDW6cgZ
 QACgfmFG3kjaxyUKZhIlxXoKS3oIfWIQjwjSVFt_zv4vw3WjkP5uC6JreA2NGv7pYvvgKajtRw.W
 coO78kVLXYnErUnSllks_8B4TgHBxlVwsHHzjlMVtVXSWL5ELYqtTvCq4IFJASbDf5pkV2f_XhrA
 A9pTD1FIsZJA0QeQ1otbMe7w7epnAP0_LNsp5qEnkdK0zVZGNspAjzrVsWkn9nPHHVlkRh7RMOyY
 g6jUY_DAMRhrcH0mw5VzDXiJe1EwWE9APeIqMUBRrAYKUH2GjBzEyFEkADHMj9TJJS1Mxe1CvAGQ
 vF0CoGO7hJFYjljkPij8ZG05yy1WTWxNeM4ULFs8Tl3N2Y6.Tit7zpv_QpXRu.Bh7sKFIyuoz5Ki
 7NYSZQrkcywCALCsdAYHIgpObHupaO.dREENMIUzjT5.FOv7Ruo0WUsGoz9BpCUbXFyfkxju8Xng
 NFN8rOPHKkXFpwW1IJ0cQy9Si2U9tLb9cg8MsuogJM4oCrfVEZ4q9FlRZfV3OiKzbRQczaov_Qr0
 QvvqD7P12umBApnEPDJpCUmR0a5tlhlu3kQEK_UYqvMN7WUZ3d4keGohjyCJILtf3R2WFwkaWQ68
 OWvxCu3rSH0Uz3tLKCa3oOjiqWrq_G9_W37hkDOHe99dUVgCR4WLVD_8ERArFQsot0gPB5Rb59tu
 ts6O1lFl207k1NDCi2tkXFORU5xvuwCdQHZzogGfznxqJY_3d0Tw3gB4cUuiOdgFjDb6RKMfxxGA
 wfbaumaG.31TCQT7AsStm3pGkQ_YNwsYs2MAOC5n28T.symGdArKH1MotDFPPw29akZV6x0IJoHw
 DeRXOo4LdvWacDOcoBElrjYg5vfESxvRb9xZFPvk3o4vUo3VntA1ju9FiVf2YdgyqzBkpDDAmRFd
 B3vdEvJGCkVIv11IS6rbE0vSs32ctg4Y_uxjjcKcXexMir.bwWWndweC_e52LFRJN6pr6tLcblWf
 ztWIRfxI62QUZBod7UXZYesHNKDp7g3xnZ6AF48qF61_iUnMOxyuLm7Mul2YZtlY61JCy8ImetM1
 ObJK_zM.FJ.1IA9NUtRqwNHa.DlQy8UXgeN2xHGi7tdqSYpjLRZkktJSWomy2CS434MAsAMYQcZp
 YjpvA_imkkjdsvJnArte4_KfUVJdXRYB8EiGMC5r8uzTwCDumD6Oz24gW6z08Ot0TFvePWlM75i4
 6Eb135hKULEb9.Y9_XKAVxHYX7vQq12z_MsSm2oSBHPb8oAkIWplWMVBCwzjYRWbPwDZXnXa_9I_
 mhLTroDm65t6vq_3OYnbCgc6l4Lc-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic317.consmr.mail.gq1.yahoo.com with HTTP; Sat, 29 Feb 2020 04:51:33 +0000
Received: by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID 16922bddfd3cbd213433d5c12bb81660; 
 Sat, 29 Feb 2020 04:51:32 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v0.0-20200229 06/11] ez: lzma: add byte hashtable
 generated with CRC32
Date: Sat, 29 Feb 2020 12:50:12 +0800
Message-Id: <20200229045017.12424-7-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200229045017.12424-1-hsiangkao@aol.com>
References: <20200229045017.12424-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

which is also directly taken from XZ Utils for now.
Maybe it could be improved later.

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 lzma/bytehash.h | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100644 lzma/bytehash.h

diff --git a/lzma/bytehash.h b/lzma/bytehash.h
new file mode 100644
index 0000000..671c878
--- /dev/null
+++ b/lzma/bytehash.h
@@ -0,0 +1,69 @@
+/* This file has been automatically generated by crc32_tablegen.c. */
+
+static const uint32_t crc32_byte_hashtable[256] = {
+	0x00000000, 0x77073096, 0xEE0E612C, 0x990951BA,
+	0x076DC419, 0x706AF48F, 0xE963A535, 0x9E6495A3,
+	0x0EDB8832, 0x79DCB8A4, 0xE0D5E91E, 0x97D2D988,
+	0x09B64C2B, 0x7EB17CBD, 0xE7B82D07, 0x90BF1D91,
+	0x1DB71064, 0x6AB020F2, 0xF3B97148, 0x84BE41DE,
+	0x1ADAD47D, 0x6DDDE4EB, 0xF4D4B551, 0x83D385C7,
+	0x136C9856, 0x646BA8C0, 0xFD62F97A, 0x8A65C9EC,
+	0x14015C4F, 0x63066CD9, 0xFA0F3D63, 0x8D080DF5,
+	0x3B6E20C8, 0x4C69105E, 0xD56041E4, 0xA2677172,
+	0x3C03E4D1, 0x4B04D447, 0xD20D85FD, 0xA50AB56B,
+	0x35B5A8FA, 0x42B2986C, 0xDBBBC9D6, 0xACBCF940,
+	0x32D86CE3, 0x45DF5C75, 0xDCD60DCF, 0xABD13D59,
+	0x26D930AC, 0x51DE003A, 0xC8D75180, 0xBFD06116,
+	0x21B4F4B5, 0x56B3C423, 0xCFBA9599, 0xB8BDA50F,
+	0x2802B89E, 0x5F058808, 0xC60CD9B2, 0xB10BE924,
+	0x2F6F7C87, 0x58684C11, 0xC1611DAB, 0xB6662D3D,
+	0x76DC4190, 0x01DB7106, 0x98D220BC, 0xEFD5102A,
+	0x71B18589, 0x06B6B51F, 0x9FBFE4A5, 0xE8B8D433,
+	0x7807C9A2, 0x0F00F934, 0x9609A88E, 0xE10E9818,
+	0x7F6A0DBB, 0x086D3D2D, 0x91646C97, 0xE6635C01,
+	0x6B6B51F4, 0x1C6C6162, 0x856530D8, 0xF262004E,
+	0x6C0695ED, 0x1B01A57B, 0x8208F4C1, 0xF50FC457,
+	0x65B0D9C6, 0x12B7E950, 0x8BBEB8EA, 0xFCB9887C,
+	0x62DD1DDF, 0x15DA2D49, 0x8CD37CF3, 0xFBD44C65,
+	0x4DB26158, 0x3AB551CE, 0xA3BC0074, 0xD4BB30E2,
+	0x4ADFA541, 0x3DD895D7, 0xA4D1C46D, 0xD3D6F4FB,
+	0x4369E96A, 0x346ED9FC, 0xAD678846, 0xDA60B8D0,
+	0x44042D73, 0x33031DE5, 0xAA0A4C5F, 0xDD0D7CC9,
+	0x5005713C, 0x270241AA, 0xBE0B1010, 0xC90C2086,
+	0x5768B525, 0x206F85B3, 0xB966D409, 0xCE61E49F,
+	0x5EDEF90E, 0x29D9C998, 0xB0D09822, 0xC7D7A8B4,
+	0x59B33D17, 0x2EB40D81, 0xB7BD5C3B, 0xC0BA6CAD,
+	0xEDB88320, 0x9ABFB3B6, 0x03B6E20C, 0x74B1D29A,
+	0xEAD54739, 0x9DD277AF, 0x04DB2615, 0x73DC1683,
+	0xE3630B12, 0x94643B84, 0x0D6D6A3E, 0x7A6A5AA8,
+	0xE40ECF0B, 0x9309FF9D, 0x0A00AE27, 0x7D079EB1,
+	0xF00F9344, 0x8708A3D2, 0x1E01F268, 0x6906C2FE,
+	0xF762575D, 0x806567CB, 0x196C3671, 0x6E6B06E7,
+	0xFED41B76, 0x89D32BE0, 0x10DA7A5A, 0x67DD4ACC,
+	0xF9B9DF6F, 0x8EBEEFF9, 0x17B7BE43, 0x60B08ED5,
+	0xD6D6A3E8, 0xA1D1937E, 0x38D8C2C4, 0x4FDFF252,
+	0xD1BB67F1, 0xA6BC5767, 0x3FB506DD, 0x48B2364B,
+	0xD80D2BDA, 0xAF0A1B4C, 0x36034AF6, 0x41047A60,
+	0xDF60EFC3, 0xA867DF55, 0x316E8EEF, 0x4669BE79,
+	0xCB61B38C, 0xBC66831A, 0x256FD2A0, 0x5268E236,
+	0xCC0C7795, 0xBB0B4703, 0x220216B9, 0x5505262F,
+	0xC5BA3BBE, 0xB2BD0B28, 0x2BB45A92, 0x5CB36A04,
+	0xC2D7FFA7, 0xB5D0CF31, 0x2CD99E8B, 0x5BDEAE1D,
+	0x9B64C2B0, 0xEC63F226, 0x756AA39C, 0x026D930A,
+	0x9C0906A9, 0xEB0E363F, 0x72076785, 0x05005713,
+	0x95BF4A82, 0xE2B87A14, 0x7BB12BAE, 0x0CB61B38,
+	0x92D28E9B, 0xE5D5BE0D, 0x7CDCEFB7, 0x0BDBDF21,
+	0x86D3D2D4, 0xF1D4E242, 0x68DDB3F8, 0x1FDA836E,
+	0x81BE16CD, 0xF6B9265B, 0x6FB077E1, 0x18B74777,
+	0x88085AE6, 0xFF0F6A70, 0x66063BCA, 0x11010B5C,
+	0x8F659EFF, 0xF862AE69, 0x616BFFD3, 0x166CCF45,
+	0xA00AE278, 0xD70DD2EE, 0x4E048354, 0x3903B3C2,
+	0xA7672661, 0xD06016F7, 0x4969474D, 0x3E6E77DB,
+	0xAED16A4A, 0xD9D65ADC, 0x40DF0B66, 0x37D83BF0,
+	0xA9BCAE53, 0xDEBB9EC5, 0x47B2CF7F, 0x30B5FFE9,
+	0xBDBDF21C, 0xCABAC28A, 0x53B39330, 0x24B4A3A6,
+	0xBAD03605, 0xCDD70693, 0x54DE5729, 0x23D967BF,
+	0xB3667A2E, 0xC4614AB8, 0x5D681B02, 0x2A6F2B94,
+	0xB40BBE37, 0xC30C8EA1, 0x5A05DF1B, 0x2D02EF8D
+};
+
-- 
2.20.1

