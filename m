Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 410512C6411
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 12:47:54 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CjCYL5qfBzDrdX
	for <lists+linux-erofs@lfdr.de>; Fri, 27 Nov 2020 22:47:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1606477670;
	bh=USTcMzpc7iph64un1rbYlHqz15leITet7xrFimgkS3o=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=KQn6JpHu+kSJT2t9FuagQ76zYzYv5kXavNleq0lVlaeR6/bghTG1tzqQVGgAO1kdE
	 1hoaswojdLQ5XXL/J9GHgsGJOtIwx0P6c00yL/cXM2HWaqQp6WdJSi6DE3e/lXRZEN
	 DCHRfGX7DRUbtsnw2nYJSkBkQcjVgQrSFOKWbQefI0IjzHkxcr/BRudkQKvZNKM1Yi
	 2jDFjwKGMkhfGqUAXLwtWI0j+sCL27gn/gMQEMU4XEgIZgo12OrugI3UvBVWD3LslF
	 LhQxI/dvwszp+PRU9qFP0o6aYR2tLldC4C9oB7CJ0V06ckRWRJerhurpoiy7jUwwKP
	 Us/XMUh4E01rA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.82; helo=sonic305-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=CGzeXi9J; dkim-atps=neutral
Received: from sonic305-19.consmr.mail.gq1.yahoo.com
 (sonic305-19.consmr.mail.gq1.yahoo.com [98.137.64.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CjCXH3wtwzDrc1
 for <linux-erofs@lists.ozlabs.org>; Fri, 27 Nov 2020 22:46:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1606477611; bh=03aomWJ+jwRinszICiXMYbsl7vdihPtekkPowYDa+Nc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=CGzeXi9J6c74yyvlH3jcYbQXjXIHE41+1Bx5pLoxW+0i8MZ8srEPUdbs8Nl93T6y6pzf5MxaTaz85wpIUKx3o7th59P8Y0J8jAEscEAbhicsxhata1x2y0lP6PgGWsMFgfF8z+zn2qPfiQo59vaS5xz+MwZnfcyo8r6V2yCRpl0Y2HG35FX3W6BNoaObG+sMR9+IrfAgIEkWJhcE/qf1ace38hJP6EYUn3xC/nV9Aq3oJddaPh/IXq+7tpsEkVNI3WFTg8E5iiUabS3aiyPjcKcrZc/0IqSAMoGS133LpyAiY+w7Yg/SOWdf1KoQxpcY6rvqO8ZmeStYaVY/yQG4Sg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1606477611; bh=KPaQItyKxCaaQM9MgXrWL+kGIffmzZViXxl/1jST/a1=;
 h=From:To:Subject:Date:From:Subject;
 b=gDcSgylrsGFso9Oy5Ckziz9WP+x13ftnA+EQ2Yr52cF83KSuGHSoOips0xtrbgpUm9AjpZU3ETn6IjHutg3zQ4LrRlkDuBanzXG5dW9r/tzxfm3Iyvq1cGFI97TtlRgd/z9e2v6tr44Lt+n/LLho6CopGhVhoGm5nwaxFhtjTYAzAuEMrb4K/FqWxXNx0ZnbbbfVgAdEBSqenQUFdB5uH50go8reFRmLLu/p1B2hXL8q0X2y59IMm3SECFiomMyVSBODcWpVNa+0jO/mBmNQo+34n5OqfGQP7DoO0n2SIldGBomJoFnv7PxFW9GQ3eCzNDm35kp15g4eNJuPEYjlTA==
X-YMail-OSG: JwRYJHMVM1m3wFvC0RG02Lnq_TA_b0IMKoZExiBDplBJri4TCjXEdBDzJw98Bpp
 t5AOEnhNDH3XNkf4QBRVn.rNfGEGmzt8lGjPOzJnXSmTbzhrJT0EKisbts8xg0.fhjw_TEAhDhhr
 sYIptd_d6C2Xw.6YgEhb1MK3LnMdCzOFmgj9BgtCY.u8O7QxmA9qsFdbak.bMVk2hHwwhZ0Y0bYg
 QMtyf_aMwUxUFJ72eCkVJM981TTDuj5YzfzHgv7V2bflgvXdeezQmmJA.pu7mf2oEn23e5VBZDfr
 IVesmgXDZK7rw54x5RPu6litufzvvzFZjS3aKCPpkdrZqIBYlc0LdeJAOz9SMaIhnIU3Z2EnzCP0
 CMsw2zLEMXxVt4N4a1.zDNFzqD6mRDiVcPgM5x5LJ2Ks64Cb0J64I3wbdjoU7zn1nq5o_rkOoyIr
 74VdlBHx7.KFCftgEGsZs7_Nof2oQ.weJCGdkUhmjw4sHyhERhqnAIFBTvYJuFdBzpim6iapscIG
 BvLgyo8z2KKmBVU2lXWpGxIt.wG6it4jdMiwEdAxH0kGaGjuCuJU6undjkSo4TQub1Oc1ownAm7A
 LPev7mP8jcKZsPMsXshWWF5RcbYE6aUwWoz1CduhCMMW397FmPLr.iwuPI.Uy5nwqfC9JtZTLT9H
 HtQ1AcVzcJhcOxyCBdeW7niGjxjvblzVPwl9Di7j1gqygDXv2RcfEOtjqdNF1.2JVFLQHlWC60sf
 z7J9za_3b0VAJn0bTgBG5sqf68W83ZBHj5Bw7_5b8JuDA3vuHdEhbyUmG5WDyin42Mp4SYBTq0zC
 KGS0eEKV1PkEtVwYyrGL7VkBJcbaFeN1j2RAG_Tvaj7UqNvh9mLWFb.sTd9TU7L3Tpf7uz2O2A5I
 8QX2wKOPFnmAtJZ694usuY2hRfU5iLCHYSLUg5sV38ESTJZz60z3tlk_E5DuGusi7hK9nYEiXq4D
 6z574vuTQlLXfTpmW3trC2jRGzlYyKN0nycqArRT6agJUsUpsuGAH2oNx6e.8L4063JFvxSJx2S2
 OvcHLqtGXVJ.0ILGkHGj8YRXb_MOI5EsD.gjx_ZonlbkdjOqDvsKS8AB8VXJMQSbAiCicFDz9m4O
 0uJWxDRRoE8D.KsoWbvdMkUToPU1W01NG8x8vdyg76pI4AWlsQyrodIfwxT5TuLUQPD25CoF_hBp
 BYsmwat1WHSsOHpRlarI0Zxl5pykwpGk8UuEqdu6bRFmujwKwE5_eBGChbh4jkFhLHSTd1KSinCu
 t8Jo4x.COAQwi_wDH4KSZ_pVcnHLO1JMo96dj83eEa6txcoULzqG8SnXWqvz6xbtTzVBMxWoEIEN
 yt7QL1v6GouQXNLcsWJUCkMk3lfW7brn1VIXgC79qzoRC_zMdMeyucuzNgLvS6Cp1MCYq9Qb356b
 .MvOycQ3PH3A.KeLnmMPgUAwI3UgU4rYJi9efl9olLcdv64cHP3Csb5VaZyRpJUoCAVea4YQe0c.
 qByvjdiIH1yAI8LBXy10zhHQPWNrSOJSx.Tay5nGbbXDOrepU4cY5cnqpoiCdXj2HVZmFiLDzIUB
 ZCdmr3hsgNbKwa3d_zJX_8Ek8WRNMqTO9VVbSNb_OEBgkTHrhCvMrj7Z11bJ.B1.0sNxfuYznUaJ
 2X891lLS9GIZNmA3iKLywovX1n.zrTJury3nbOL.FkwqbQDbjAbY3hbQ9gE4foyUnqi_nwkibySf
 EZOYsDqhwEkdu1.qrcTyCWK2lq3LfS5hD8ECdEyzrvEBjysl2hUfbmT5aedwRbvRVOF.KEcntGMY
 ew3DcNbPK6T2Q74VWGCtelcTtHBHwPrkJEbIRCfyTPizT7fmyJCckI6LJZYXCbOB39q0Qr6hDjIo
 9utYf3mWOQ_XsqWRyrx3aQypaO13hmV0Edf4wJYX5T1aH2.2RoDVnBlSWILUlYyGqfawOkQvUBtC
 dl9LJ7.Nyj9XPeK_lW6jhCmK0NeT7DeYnMQxDaUNfGkTX97hQ10.a0pM0Du1j.8tCNCT7RSiny04
 cKtqp0cez4N4QQiaD2EPprJza0V9HuzDjP8InnMT5I7DMRcKZkCQiKGEae1g8ruuUHUEvyb8Z.hd
 .NoC24XIyCv1HF.PBdd_PU8YTYo5vb8Kncth4Oo3wrCKNPwxGWwOJfTA0i9N8YIhSijqlcmZiRZb
 RH1dZ7q8Yv4_ikDO8BOTk4Z9yAKIYeMZyJA1ZVK6MEC7GYE4oCgMYVOGbVe0cRp2ZshA5.thsgfl
 e3gb9zJVDiAV.2TiBHTU17kSjY0AOSMH2HJs19ZFiA5RvZsGvrY3mCSaCBFfJIDPmF1fkXIvv7fc
 yR9ni8E7zm.leO_m.3UCfqtj_4izOidWAJj2rMSQTZ9Kqh4YrdGZg2wgYHlkD5vrk_vjf3vLSh07
 qKAx79twgROqo2kw7FdNFc5J4sSQzNimszRoAQX6_gMHit3xm.83HXSYCFdwOEAwZfJfmhOLlz8P
 fEfNbwkNoIg_RPfZieFl7GevLcQ8Rrs_K4mlZ2VBgB5PyC9TPd0oDS4na44vcpgZf4MEWLamh01T
 X8NQESaugcXU.ORiPwpKPMwb.EQx6cjn9o75qZl97Ocv_86ZOUVle9QilE6datssyBHr8nPgxZfm
 RJyU4i4SVVmP3wTKIlGq4HKhxbHiT_2w4CmxtNrpZ.mQRNYgYkucDnc8v2F530kKB15sNjM9OWi.
 75Nwv3A6fYXLUBpVPWFlX5bz0oCetgqDLCi3OiHT59O2JQThwAEd293iFge5E2VZrxQzyljmG9xg
 8oDnFMLIPsNt1wGPQEhwyCLSJNRIh1dRKnd_beBjPrl1VGtW7okkZmcESTXcK5qgRLX0IDFiMKCa
 ZwINiRAvWuaYj_mZG7g7uQxcVOzt7QjzqtaA6TCeiAQ--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Fri, 27 Nov 2020 11:46:51 +0000
Received: by smtp425.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 3a2b2602d95632a301ae818aa8f56dbe; 
 Fri, 27 Nov 2020 11:46:49 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/3] erofs-utils: fuse: support symlink & special inode
Date: Fri, 27 Nov 2020 19:46:16 +0800
Message-Id: <20201127114617.13055-3-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201127114617.13055-1-hsiangkao@aol.com>
References: <20201127114617.13055-1-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

This patch adds symlink and special inode (e.g. block dev, char,
socket, pipe inode) support.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/main.c | 10 ++++++++++
 lib/namei.c | 22 ++++++++++++++++++----
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/fuse/main.c b/fuse/main.c
index ab8a90aadf8a..1e24efe110c2 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -78,7 +78,17 @@ static int erofsfuse_read(const char *path, char *buffer,
 	return size;
 }
 
+static int erofsfuse_readlink(const char *path, char *buffer, size_t size)
+{
+	int ret = erofsfuse_read(path, buffer, size, 0, NULL);
+
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
 static struct fuse_operations erofs_ops = {
+	.readlink = erofsfuse_readlink,
 	.getattr = erofsfuse_getattr,
 	.readdir = erofsfuse_readdir,
 	.open = erofsfuse_open,
diff --git a/lib/namei.c b/lib/namei.c
index b05f5c421d54..e8275a42f090 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -15,6 +15,14 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 
+static dev_t erofs_new_decode_dev(u32 dev)
+{
+	const unsigned int major = (dev & 0xfff00) >> 8;
+	const unsigned int minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
+
+	return makedev(major, minor);
+}
+
 static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 {
 	int ret, ifmt;
@@ -57,10 +65,13 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 			break;
 		case S_IFCHR:
 		case S_IFBLK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev =
+				erofs_new_decode_dev(le32_to_cpu(die->i_u.rdev));
+			break;
 		case S_IFIFO:
 		case S_IFSOCK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev = 0;
+			break;
 		default:
 			goto bogusimode;
 		}
@@ -86,10 +97,13 @@ static int erofs_read_inode_from_disk(struct erofs_inode *vi)
 			break;
 		case S_IFCHR:
 		case S_IFBLK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev =
+				erofs_new_decode_dev(le32_to_cpu(dic->i_u.rdev));
+			break;
 		case S_IFIFO:
 		case S_IFSOCK:
-			return -EOPNOTSUPP;
+			vi->u.i_rdev = 0;
+			break;
 		default:
 			goto bogusimode;
 		}
-- 
2.24.0

