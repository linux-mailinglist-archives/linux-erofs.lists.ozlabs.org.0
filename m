Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F92CF304
	for <lists+linux-erofs@lfdr.de>; Fri,  4 Dec 2020 18:21:26 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cnfcz5mm9zDrdR
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Dec 2020 04:21:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1607102483;
	bh=vE9NUd5YnV1K4KnSC75QbwZ4VYKqp+lxHMcppIHuB9A=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=O96ZcnGjOgMP4N2T5mOLMiyY76vgRMTTLkL3PfQds4+9hsmYxRY4hTjDz7tbPnTC4
	 zXtV26Eq4cnA0TCOu0R7Jms1ECzUL+TrC0f7VpcCIEONBrBpSMQiC/0K/h9xzU9fzO
	 OixGfkmAeJtOVMLZBnBEHp3QaiIMPLeoJwNKVimdfhYT9akW4KIhlhUn0kbFVhkKmA
	 ScE13CAwjFHVJBCT8ZfbDoQQPuR3VpTv2vZdXC+TEK/TN52PXnmOtDDqXGibY+RwHi
	 tiB2Ovju16cJ6MTvJPgnfOuygYUmTjMPvoRGsGW/K95Om3B3VvQ+axiXV2+kkx25Qg
	 8YclwZAxdg7sA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.83; helo=sonic306-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=fnLkc3SY; dkim-atps=neutral
Received: from sonic306-20.consmr.mail.gq1.yahoo.com
 (sonic306-20.consmr.mail.gq1.yahoo.com [98.137.68.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cnfcp65S0zDrcN
 for <linux-erofs@lists.ozlabs.org>; Sat,  5 Dec 2020 04:21:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1607102466; bh=i2OQoy0+PaduBT/axc3/Dv0dX9Chu2H8tChbfY71wA4=;
 h=From:To:Cc:Subject:Date:References:From:Subject;
 b=fnLkc3SYfHRpEZOzSdJy9CEHiOc4rbZDouhp3FWlnCHO+h4NtXIIIK8ylnaUHuyfCmhmLjYz7/VfoDa04uV6fNM36QeKSE5DW4ijPNixCHgqImYCUwcyy5ueFNRcFJf0gPnYjf4xOnoseqQsZV4SnSogQ1odSCLOHC5oBV6Vf0CcNpJ0Pw061GVkx+bsKy47/+GawU9niDKN0jbdU0LGD8gKDwTKJcjjVH3NrG/77ox9REjVqrFFmgJ2UwQmV730ODmw4HMCMC2P2cl+vEs09q8fOxUEWEBZtfz64vqD7RNzUiUttXe9oyr+JJhNy0Ojd7jrkWo9UceTeAFt3HKxHg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1607102466; bh=ck9t/cLZTll64Rdi/UYUSZxXCu+X0HQkDWdk97YcfgX=;
 h=From:To:Subject:Date:From:Subject;
 b=F4/PUCmDJTEwL92xq8NH0mR/UgtYmnqDN9xtzNkyB2RqOBYWUpsGVtwO1ohEnys5VHw6gQoJ8nNJDwvWjwC4AhkgNxINVcoUma7NHCwzoVX24anVOc+5QDaoo7F7ANwZ24asjYFgO3PAmPlHOQlD/yB5Piom8dtiM/L1ob0UMPED8jU98OPqS82FYD9pkPhKPnR8iBIAMyjjqZeyuaGSTW7lHHORr/kl6y7Hj1n579NnahgZG3+zQ4DeXbY86dd5SwImqe2un+5HeV+LAU9Yq5ofsWoCwdStbrcHrXb3U1svvPIiHAJmyd5V5JJmij2SV9PlOYWajBX1G0+rsnZ4MA==
X-YMail-OSG: QX0jtVUVM1mT9fkps9yU5Qx.HCerdQSgBJJGYcjRQu80Ehx8NxxIcJ8MI5CfA7Y
 4he8U02ixWcasCWo4pKiXK6P3xGdMJ3FoXEIt_ciesCRRZ9lqzr2ZSzl27xbahtZSck8BvNxP7D7
 E1JgqR9swSEl7HzybNsGNJigGIBfSjK4RYVV5X1tOBdIkqhfpwW15q6jFC08nO0SHLihPlDDHjfl
 J2ycJO0lIMbqm1G6rGCdSmrM1e9GRp85KJtLJRzvWGcj8saWgzx9URrfOZRkHPwtfi9Ggn..c8uf
 zeFrYYnMKOw.Ojq0h583fYTrbXc2NqSdVSZR1g3TyoAf8sx7ZloXfB2pYDbNWtCf9ppynmX56otf
 GLDe1vS6IUhxzTvvDTDXtMp9FXfIRp34ricRkrr6SJPPwspLBqp5LB5xmGVKRmr7jyQamzXcsj74
 CtYYpyl4QsW3qvHYUSm7h1ZZGf30pR7Trh3gvJlFAfjPeTNXuCMImZbDWR7q7Znq3YB1KVxq3Egc
 5hkEOjXVmzL4TM6Ju6tU2NozxsYaYw5kBhew.GQWVa7iHJdpfx.ud1ji2wKs8pKcNfvVWmShouJr
 MRXxBH3oIBrutu3hmn2yfmmW7JAWr55oFLlyZqe7hGSLmc5OfAI5sJ4vnS5t1t6r1TdUrU3lxgTn
 Vaa4p1gARH9wIeeUL7l.IW8FD4Mi2tEuIPh8RQerGbZygGlKq1ectOXKqpAD.Ex_PgAU35kS8NM2
 hU3jAcdaRpaChugZLTlvbCpRLGCew2J1qH_a0A5GNaCLOBHdMFQwfmcgaJrG4wQr_PyaTW_nQ2zW
 1pZ8DeZ7_H8nkWPlrEaufz8tXaE9dUfB1738jl2MzSwd9pNLP9KD0JQfOkt8TzgyNY_FpSFn7aEx
 7UkzmagpKblPpvnWpK7gItb3LhEuPVCbi_6gx3sBDewNt40rzpDNZ0yCSJswneXHnPmA0WAphJX5
 wdoLetnrVRWRLClQ.B.1A4Dz8bEwOR7Hl7JhkFbGoD4b0t1qlsVUL6bbYFXy8P5EMf7vxc8yj9An
 yQl3hwylWr7KYbA.k336E4G33JJDIWbSnLOCGZg1DVZ1agVanrZV4UwbIGplsP8YD_8w__BqLNPv
 NJILiVCi.UkK6mCRIVSGLQ1Ab6hZ3tQFhJkDg1i5TDu.B0weDV7hRNNAQ3rvKRPaJ3ZeM7shO5rf
 FDQSkG9Ukn8AuWyXZ8DAcip5XajCGnjHLXx_TT8IYteiya_eFeKASUpHAABm8tiP._Kt8wJcOcx4
 sRWE_Q.iLIY2m_QCzdu8eKt_Ib3rZBcTEoABQ82RfCeGEjlkrI1T9ezM9Xz391Krry.nmtTeL.wn
 0p7ZtJWS5Pg6UyI3RjDe8v74hkNeqsuZJI1qo8.B9RjLwIUauy7ltEjKmUDr_ExGvfpSCYf_gbxE
 XupkiSIBoT.DuywqPoYfKwfzK3Sh7AP1wZjICOgx.6mX6QN1uNOYQ6uLDHsDjI1yX6SMMgU5acy7
 .mpkPTawB3zHNtX71.8E_JJfCn3YwgvTu3.CwWIHmaF.ELdzO6.rJmCzFqYDAxxKuewEf2DknZhk
 LmeCIvqOt4v5MlwdFv38A5wpH55jT35cB7wRCYjXiH1gSeME8suqS4TMe.vVZWlGaXsdUJELvP_I
 1dcQ8hg7gqcDnLMsUSkDVg4LklwuewP4kMHeI1XJ83ZLPu_yrEyeNNAYQpElDWv4JvKi88e344HW
 pubAtITpinO99ft_sspuBuryPdVTqgg0sr64nwVNCKnq1uVwKfZSLPY_722OndxGBQZRA844p1Uz
 v1TemIOTj.CnvqvNmuuRgyZO0TnsdBRHq3lWk5YsLVQxt_MAuOE44l5pibvRJPj45i.3GYSyFFOS
 GUN.hCYF0K6MVW0zhkiyBZ7.Xx528cWryNbxd.o5AdNyt28ttyOnvUZtMNIMPTm_BOzyjLVWbKVU
 FQC7n2TyPped_rAHJ24V_7qGfDX8Ng7WIHyzQia1CooEPZnU0ic7HQ2ttO96vp9I8xjjAX3bGH76
 r9ABe7fLRxXCn_MxPAcqS_MeM26QwAQS3vykfTA.sd.aOqVs1zAJxYvZgK_ELbnjv.eZS18oD2dJ
 KLfuLt8fcto.Ey.6_z1xUoOXWJAAlxbIPZCcUuAaGorICCYqIfN8ymmJn4w_ZNj3hhz0os09_VI7
 G_CyKnpNqPOWCcSwmFvD.Se4O3w6A9dCuq1RoItypEAE7sCKRkAuAXJvVuWNF3wkYKnaRHoDRX_i
 D9OWNEpOC0fdyho_L3AgAvEuNQAdP.9Za.bJXrHL5lxW9ypuilJwcycq2xqVTqxurfPpQ2s9TL8d
 RfpbyMQV9OrP5Q4xW8ca63b4UlbFZEDHg0BRlGVoG8wUWsv3LJYAT90BKj4WXUFkwK1TJeFRpiMf
 _HOLSc.ot57XAOcGxmLMstIy3xbtnGEmGMODOn0HLoB_8z6L1B83aeFKvsNKBkXLIlsNIfoA0Qmu
 1WoLUIetyQjLM1SbJ_L4zRjxNXbI5hI9CXWmJHZg5.LnD0tc-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Fri, 4 Dec 2020 17:21:06 +0000
Received: by smtp423.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 08fdc92c5476471ec5c1d3f3f35296c7; 
 Fri, 04 Dec 2020 17:21:01 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: don't create hardlinked directories
Date: Sat,  5 Dec 2020 01:20:41 +0800
Message-Id: <20201204172042.24180-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20201204172042.24180-1-hsiangkao.ref@aol.com>
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

From: Gao Xiang <hsiangkao@redhat.com>

From: Gao Xiang <hsiangkao@aol.com>

Fix an issue which behaves the same as the following
mkisofs BZ due to bindmount:
https://bugzilla.redhat.com/show_bug.cgi?id=1749860

Fixes: a17497f0844a ("erofs-utils: introduce inode operations")
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
regression testcases will be uploaded to:
https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/log/?h=experimental-tests
for now (erofs-utils v1.3 will include testcases then.)

 lib/inode.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 388d21db3845..1cf813daa396 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -823,9 +823,16 @@ struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	if (ret)
 		return ERR_PTR(-errno);
 
-	inode = erofs_iget(st.st_ino);
-	if (inode)
-		return inode;
+	/*
+	 * lookup in hash table first, if it already exists we have a
+	 * hard-link, just return it. Also don't lookup for directories
+	 * since hard-link directory isn't allowed.
+	 */
+	if (!S_ISDIR(st.st_mode)) {
+		inode = erofs_iget(st.st_ino);
+		if (inode)
+			return inode;
+	}
 
 	/* cannot find in the inode cache */
 	inode = erofs_new_inode();
-- 
2.24.0

