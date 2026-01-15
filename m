Return-Path: <linux-erofs+bounces-1889-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 53099D26BD2
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 18:48:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsVns66Khz309S;
	Fri, 16 Jan 2026 04:48:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768499297;
	cv=none; b=gHbUXECqborIdEAp5hc4Evn3aSjbJY6l4m/CvB6J1ymsZulZl+QJNwhLjtGQU0xUb8JiEB/P/ZSdTXvFhprwnLzb2WPIXOfhTv0jzJa2I2VJwh5p/nX0A6mkVhV/2GAQf0Fq/oDTf5dGDrPOJPOmFo7QAS4xsfLCTt5gPT5z3k53rum+ZBD7B4//qU1vNvE1wiKjSL3x1JIR49MRejTc3klCA6tVVy7JjbmMUt2Le7BT+aoIQHACeBlpysxWA4wnV+y16KW5qRAuKG08Vx7NLwoslUY2tVDsOdY2F8QPsIwfXSL4QQI8Rcl30je/uCU6+MvaMZpzGnpikjvvTvq8fA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768499297; c=relaxed/relaxed;
	bh=hoRx4iqvApY4n68S8X82ro128OMPf7po0KQOiKAg9pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QnM3Sf1QeebPtPcfk/7WQNAs5mCFjch6H176FmpCz8OEXvH8dD7EFgPwmnvZRxEvJDrPN7Er7ZlYrgtZRPYm4oCmFD8q7lhBtz+DDk/bfLKiv0Kq6z9ILoAnhYAZPg3TnRS13A62sl6bku8WP81jk81ciBBYpUPvDADk/afDSG/awPYfIvcP/1vaq55s6Vn+jdB8Lpwf0gJMGnGA4T4wIVfJredscmpWjxAKejn2ksx7tG6U7sI5C4zPOyxH/fk0RHjjN08x/mo7aJlcrFKtEbLIbT828Orz631aq9Pcq1S8igtiu2lwn4IzrkZThSR6GOON9+//ABLwuaPtd1Iv7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N/aT5jS7; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=N/aT5jS7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsVns125lz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 04:48:17 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 88A2B433FC;
	Thu, 15 Jan 2026 17:48:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B80C2BC87;
	Thu, 15 Jan 2026 17:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768499295;
	bh=eGzcrbK82AAYHA8mp9BK4OkYs2dNeYeCsyAFHAtDQCg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=N/aT5jS7N6QoemTXHYE0cX8UVkbOu2/wbixgEVBgnGYF7LhX8OhNz4XrWyrjWRC7M
	 zD29UA1bZK9fVBcd+hA6xYgcgJEJ2sOcHLu62k3G02+2GGzKX/VLC9noXIbXKuuT5K
	 Nr+33LfHhpTNa+foKCiyUmvvq00e+Du8qeu6aHkC+zm9MykELBvSIJbtqfNnq/OaOK
	 SF+mPjA+LVjF+9H+bIal6zl1BUwjpoAojxDJr4szcfYTYT5pi3BOBaWc53Pi/XWVcL
	 UUg6FGToVwTQewnPmGxKUIYtkaiiQBopAjTCdSXAr5q8BAP1a33Gv7jD+4BPFrdlhn
	 7fI1YzYPg+SYQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 15 Jan 2026 12:47:33 -0500
Subject: [PATCH 02/29] tmpfs: add EXPORT_OP_STABLE_HANDLES flag to export
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
Message-Id: <20260115-exportfs-nfsd-v1-2-8e80160e3c0c@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=687; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=eGzcrbK82AAYHA8mp9BK4OkYs2dNeYeCsyAFHAtDQCg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpaShEbLwccGXUC5j0WTeZML8RysoPsUjSds8pC
 JZi3m3aO2KJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWkoRAAKCRAADmhBGVaC
 FVG3EACMORg6FWU2k+gTVXQsRhFWMoWdpO7xBjnubHZheO/O5JyWKYWNPX4sbXBvJB6B7Jk1/b1
 MaY4i/BdFxaDMt69GQfQWSs/ZjgMLW4LaHiT35v+0ApKcyuUcyUpGbePY8Q45RmV6DfOh9whS9I
 t8sVCOKSYWlli98pTJRslgDUbjULTXyaFW3R08JP3i5prQEUPNI85rq3Ia39b/3nRxCeLKaHexo
 Wh8mjzMVA3ncr3QS3JDW8EiM4mJqdcnsG7C0p0NsRXX9Bj1POl4qDX4/A7s0z02kDavF/u2IJaJ
 vzU3qxp6MoJLJtZOYAMJEzw6d2NIMsfFQi8pwo/iMRDwkqxsFpwRvT7h8npYMpXyQRou5PI4d0k
 WHlJK66KpzRjMnk6kiLnVvwtZuUQrYq4oVkkaWTcUB+fY19qVtW1hVVw7scwCIR3paw5NG2hfJd
 yGUZ66kVaTV4kRZIMqbz4YnHGfIFhEP3jeaF0kbPpJ5OOuVTBVgLJoD+69v4diy5ByzJk/ujYyj
 EnGCShycUwb0IGd7r5f1TDdSScJ49Fh85Zg86XLyxoT3TDIvfZG2VWm5VKRN81ifgwd84hYqGHs
 dMhx7JclW4kuJSjtBkrqYaWP3J4TCUaDo3fstC9n+P/mEEHHzveE3Gf/t3MD3vm9L8CDEYfw0rc
 Din5n2xsqXt5kxw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Add the EXPORT_OP_STABLE_HANDLES flag to tmpfs export operations to indicate
that this filesystem can be exported via NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index ec6c01378e9d2bd47db9d7506e4d6a565e092185..c64c4410b4fd9961599a5ea768b469d8184e713e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4477,6 +4477,7 @@ static const struct export_operations shmem_export_ops = {
 	.get_parent     = shmem_get_parent,
 	.encode_fh      = shmem_encode_fh,
 	.fh_to_dentry	= shmem_fh_to_dentry,
+	.flags		= EXPORT_OP_STABLE_HANDLES,
 };
 
 enum shmem_param {

-- 
2.52.0


