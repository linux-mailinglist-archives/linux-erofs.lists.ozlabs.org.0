Return-Path: <linux-erofs+bounces-1910-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43039D26D2B
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:50:39 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVrY0BZqz30M0;
	Fri, 16 Jan 2026 04:50:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499436;
	cv=none; b=i4uANurqJqnoFzX5evWsLE3gitow0VPSJMxLncM2s4rs123g7ijQisOxijssYYPrPYIpTjw98FdZiQsnPqejYv8aXgnMVamx5kZOjhBgiSZbpB8alUfIM9cgyuD0CD3iZmjRnnmFxRo/PootKQwzdENjUAmD/OMWdgz0R2PxfggecsK2XTv4qxnPr3AfoK9rGxy5Lf5o+y0j7ZO43P+ROO0Xe/a9YBnCRXSUaR9GNHsJUZgAB+L0az9faRAp9aOEXR7Y3cUOndD+VxpUBZgQtL4lvvs0ni8Oc65VyNbhPq9Se9yIO0NG3MPibbnWgA/IH9k6qig5vrPo9viAq9a7SA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499436; c=relaxed/relaxed;
	bh=RGpbpT5sGMPb1IBCPwnK7v1mkqc8AIml9XaDm8oqePw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqU2k0Ug71ujgRHkkI28ngcaMC5qGG5oZbLtpqqBeQY4NlUqG08eIPYIcwSz7ObZFK35LMP6uMU6xS5cT6hWkqb+MepIsM91KZujT56lOiqGQZnGO+XUvAIaTiIeKOKuumwOmOoDVVuOsTjeIL7ASFB6y/rYvCb/e9PPIzhawq6qirnqkMS33n8hTCrFHbJ1feEC4bkFIoYmk6oNY17BBVPIGxwePOXNd2pztOXOTtePE72Dm3s0skUOx8j5NmyYzVacHMB7wk8xeWnFWZPF+oRJxDXGJDR9RwIksyHAA39t5z1TPxW61HsrBodcXYQ4Yo/pvvMGvph+fiE+e9n7hQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=il/VdfDB; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=il/VdfDB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVrX2MTBz30Lv
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:50:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AB46A40DF2;
	Thu, 15 Jan 2026 17:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3889FC2BC86;
	Thu, 15 Jan 2026 17:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499434;
	bh=Ehx/fY8sKADLaMJl7+FCvLMSAa/U8OqMGXINa886kwM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=il/VdfDB1LkGOpRnPQvrFUwdx0K2JPqnFGRJntiUMVPnRxs5PHZsfMSValtvlYy4j
	 mP/J05iJU0gPS64R8GEMOhjWoZHTdcqWYKm1Ogw222ideGX5ipm1oSmIbMKQDoynXi
	 UP645amY6X6foCDNx121QYUsH6YuE9qBLm2QyYpgyOtDMDTtrSfXKS6vvYfzeGVlpZ
	 NBXNHO0X6RoEWOVoNemGaYh4g8Rj0kVFicUqGBtTiM+GOp9CM0/rmo3WVap7u4Plx9
	 iF1KhPCMNTJlYXtmOpwM4F52XhDOSltoNylPFsa9HOjQ5jMxePli3mEAGzckJ3GyvS
	 POj6uKKk9HrQw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:54 -0500
Subject: [PATCH 23/29] jffs2: add EXPORT_OP_STABLE_HANDLES flag to export
 operations
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-exportfs-nfsd-v1-23-8e80160e3c0c@kernel.org>
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
In-Reply-To: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
To: Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Amir Goldstein <amir73il@gmail.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>, 
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>, 
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>, 
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>, 
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>, 
 Salah Triki <salah.triki@gmail.com>, 
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>, 
 Paulo Alcantara <pc@manguebit.org>, 
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
 Shyam Prasad N <sprasad@microsoft.com>, 
 Bharath SM <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Mike Marshall <hubcap@omnibond.com>, 
 Martin Brandenburg <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>, 
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>, 
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>, 
 Andreas Gruenbacher <agruenba@redhat.com>, 
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
 Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-ext4@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-xfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
 linux-unionfs@vger.kernel.org, devel@lists.orangefs.org, 
 ocfs2-devel@lists.linux.dev, ntfs3@lists.linux.dev, 
 linux-nilfs@vger.kernel.org, jfs-discussion@lists.sourceforge.net, 
 linux-mtd@lists.infradead.org, gfs2@lists.linux.dev, 
 linux-f2fs-devel@lists.sourceforge.net, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=695; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ehx/fY8sKADLaMJl7+FCvLMSAa/U8OqMGXINa886kwM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShJPTKQVJtR38HPlADggm6IpGXuFgpgP+f7i
 KyE9A2oIKGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoSQAKCRAADmhBGVaC
 FXW6D/sGkS32C0CvjQ+A3ll9zy6dfI2gSXvXs2ERkXcQcsSsv5r/hSiEtw2RyBxQyx6rumNm5mE
 QyUFWXbdaTwcwSGobqehxKp5MKzzcfp66q/Zpo2jAaY7Da35SD3PyLH2KIbv+fiLrBBo7g4tDXn
 mkyY0E5I7NyoHgkD7SQ01nu7bbMi//dbuZJ6f4swfTGiZIdiCkQdMPdK8Ab1nXZBTmGes/5vUoD
 tGaMY27xGBCoU1OH0XNfDeZDjCmt0zCV1GcU2M6s5qytJFpPecsCi3g9XTpKEPAiuUVohlmUH6Y
 964nITE1D+6aDlHH/n8fXWwBcwAvWaUEd0zjh33SwdeUbgGGtpFvVIY5jZvo7+a1zqLkm/v02PD
 i8nD3PIVvfzsAadwDV0ljzI9h1nNV0XB5gAA0NYuiq2KdbpspRl3AwFGziplhIc2IfOUFi4pqEx
 SWDLkaRbFUSzetyFiUM3KqyYHrJFY7y1lO0+Rteb0YEfr2HVYP+9wA6e1xFpmUVrxVQCszE9tzS
 qbr2AirzqRv4ThIptuA5w3v8c5ZPCJiKva4Jx3gS8TT2vj8MZlBxl9rywDy5WyKKUPnoFelofEp
 giBXGcbgNMLDfX7iQ7xtrMTIY2WQNMzmLb0/QRyfr4yue/WVp+cUchExc+2VVPEi6eH84pgNfcg
 n6TOjJhVwZKiTNw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to jffs2 export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/jffs2/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
index 4545f885c41efa1d925afc1d643576d859c42921..80ff5a0130603f94c9bce452c976753c85314c3a 100644
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -155,6 +155,7 @@ static const struct export_operations jffs2_export_ops = {
 	.get_parent = jffs2_get_parent,
 	.fh_to_dentry = jffs2_fh_to_dentry,
 	.fh_to_parent = jffs2_fh_to_parent,
+	.flags = EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


