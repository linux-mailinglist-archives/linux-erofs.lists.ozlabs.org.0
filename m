Return-Path: <linux-erofs+bounces-1897-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 99325D26C38
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:49:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVpv1Bf4z309N;
	Fri, 16 Jan 2026 04:49:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499351;
	cv=none; b=b0PTupLU5IsnOSZJ7qEu1pNK3P0GMYcj2YjmcviJcw0e7bHFVld45CwiSzIZUEzieotjFrnDC/19GIEt218/WkrCiv7WnzOcSYaW9gjhkghr9II05Fqn0KasYnW1qdSZJckIHy9oDyJB+0lOARbv0SbbjBIUQ0G4Ra87bT/pyhbzkJwhO+sJeyoXcRP8NmmP7ALGU/zfHrSDezZvMP+/MO32+Fw+Ci3MIa9T0VRct+T1c0wj9AAy3QI19kNMlKDVkUt0XlrqJ1Qa5eK+k3lJqMUgWLhiJHUbTYFNk3Rr6ReqZ+WlS6Clzi7qf8DZOUOrf1tgeA4BQJtHzcWDBNzD1w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499351; c=relaxed/relaxed;
	bh=obBvXeIihwcnYNwIfK7fO8NOfGknt4GVIgzKgx3OkiQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aR83RpymwFsb5Q6h/rPSx59U4ehPdpQG/l4acWJGzD0ZX7jkfxGBhGWZ93G1BqrfbN0Wq2pYEReJg0w0oUDSzUX7fdglQ5UY5NGtsjk1hC+fkgRvnRi8BhfUbW/GPWwm98Ym6iWb8N11B/ii8C/5/QJwN4nEZN35LkkaYGlUhA+0G7qNKaz+/chQGGvE0PPQPtgv2m6MFsIjEqLd7DmIFE7/ayjRCKhaFrJ6Tcxdx6XvQK84uyoK3fJdyFPHMXYrM5zTyaz2FFzNO0995HuJW17BsF9xXA8ouaWpw2mMfBV/qhC8NB01IDdMCSN/FaBpipQ82fyjR5FCiasBT3NDLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bwHkGr2x; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bwHkGr2x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVpt3NCJz309H
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:49:10 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B04BA43DE8;
	Thu, 15 Jan 2026 17:49:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358B6C16AAE;
	Thu, 15 Jan 2026 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499348;
	bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bwHkGr2xg6B8U5TV1PJOWofK8WpoXC25yUxxbtMAPlBPDhQrTQSG6vrqBrUs8uDBA
	 hTqGyj9yg2TH2uINyrZXCjzuH2kH/kz/XePVIL74Zs7t7dv4JpGdmbHA36OZU+DJpk
	 PWmLshHFOMRMefsxGC29Pff7c0kcVj0MxDdQhdnqdzMXc5Vap/L7iD8JqaqQDzOlpW
	 oevuq4IZNRQ60YjDnRkugrc+ROG3Hn+nEfLCVs9dFaMKHspLizBAMr2yjPWiQc5QxA
	 c/JcgLHuNUH3+8x2nXofqJfjnjWbvPUhDLylRyyE/uSqPEh1qjEcalALGwqW+YgG+k
	 G7FnxaFhkK23w==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:41 -0500
Subject: [PATCH 10/29] befs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-10-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=706; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=FgvaakP+KkZTiWPmd/GcmMQL5i/gToOI+UK+TD05398=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShGbxyozH9HfLZqQETsvfW/RuWGQpM8tpPCd
 YnS/wCZAa2JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRgAKCRAADmhBGVaC
 FV26EADSUInyFlfgi8mCxLJgVoNQbbVSxQ1aPK+W8ZC+ZjdRh0buWdJB1AqTinRIY/+hFrdznoR
 2ij1tYPigO5YJNUa1QuOcvdR1eMs/OF9F5mjiEO4NQVqjmtxFejq2q7Oz1dTaYOWKusvPa7duFk
 szeNwIHZigrHOXNHDA8mBsjuutshb2R7+3T8CzxrXHuU6KZFxQTBnItrStyDP3nCf57wQhs3lla
 1CKlKga4tIeLYArvkJaEfFiyGtqtctzSSWRbprAE4TqMfC1eUzsoSghWWpkNCAfpnAjcCgOcu7R
 Qd8+8pXhG4zvQtv7WVaWiYSTJtxkztKJB7aV25SRrs2bQpO/cIBvruIHhOZtV+C5KFC3q7S4Ng9
 cosmYNrH5tNiIe1f18DK3kHU22ippITqJ9OoOafSiehsarK+Z5w9Z60+Wfzjz3Q6ffD02Z8S5DS
 RUX1xUlKXgUW9ZpR86DLZoT/TJlqx52AWBrklpEV5+LQ+TC3lPHjq23gVI9GjTsai3UlHGnxhcf
 eg3VD1jJijVL1y3CsI0JMk0j67gHyCkWdQ67/MjF+DYzMfmLCOC7xquhxS28B9bfyDc48SyRAG8
 1wZJtPzPzh+aXjwMzsqJICCOR/ExR6mP1AJk+vFbe2nB1tS5Gyo721I/mFPhRhvfckkPX3ujRj3
 8k2oLoDOYoOrrmA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to befs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/befs/linuxvfs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index 9fcfdd6b8189aaf5cc3b68aa8dff4798af5bdcbc..1f358d58af8b4de9bc840b9926970340395bc9e4 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -99,6 +99,7 @@ static const struct export_operations befs_export_operations = {
 	.fh_to_dentry	= befs_fh_to_dentry,
 	.fh_to_parent	= befs_fh_to_parent,
 	.get_parent	= befs_get_parent,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 /*

-- 
2.52.0


