Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2B09BE9B4
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 13:36:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk4T3155mz3bcj
	for <lists+linux-erofs@lfdr.de>; Wed,  6 Nov 2024 23:36:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730896598;
	cv=none; b=npilPrY1GfamcJcOA8ESukHC7mEva21Fph+K5hSObIDBskqAnBNavWlj+5LkMXP6b70savFzauFRJf+ncZFBxEV7CMVRVwYg8fputEOQmPB61ek621l/6J3vHZS+3pL++AlZDavCqlx7qtglQHbUsHeqCsFrt1c7il9p95/iEyXe/Kec1U8GgjM2z3l3Wh6fR4cb7xWhvVRwMi5KOwKNkA6IKyTfPkBNbU2ey46ASooKJgjbkh71dysHrSHbHZAfHPEgi6+FUYto9X7wqe0AHxXJ7lxgutK70nxolyb9Pyy4CMsWT21cgdqcgLRwJsscIh4j7K+JlnTE5KlnVa36Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730896598; c=relaxed/relaxed;
	bh=zFfHFGyfFLnfH39ds9xcldOHx5zC/fcdWITNBPuGcyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A9hlOOjN3VtMv7G+4igoF2O3+TXrpSVEMxtnc8VfP0zXQXcV2s4kQBn0sfYGgt4UywjqeVtDzKOM4QFg3avgzIRvO83yhiB6UDlCgeDnIr5lXQ+ZPn/M/WnLTEbwzRoXRumZKS+owRap5CrNNzW/FwXHdG65x2meMB3LwLCceaYzbhURoaz+m17dNHC2bJ6XmFB6y0+QeefLVVWV8L4T4j/lIxW+OsM4LRklmZVbeqqNx9YPtT4ZnxcKKMXIQcIe6F8BXzzgNDJ/WCR0tu84zu+9KF/f1hvAJ+UB/71bJvQ7bFWgYVOmPdtc3q/K3vhnbgOC6AFU5LZwQiFS6mrWGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PABX9pCf; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PABX9pCf; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PABX9pCf;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PABX9pCf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk4T10ZXzz2xpx
	for <linux-erofs@lists.ozlabs.org>; Wed,  6 Nov 2024 23:36:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFfHFGyfFLnfH39ds9xcldOHx5zC/fcdWITNBPuGcyY=;
	b=PABX9pCfxCMyCifY57Vyr7o/Fmm9g8dOuGNcsEDKmHyHYQW+9c3NEYLXI2sWnLFnHULlEt
	zIRe83Fnrf5jHzrib2vV4wQUpZ7OSbNfuuFgn6t5M1QmMgEXMdiQLbv3SLgAbR3oVXMD8s
	V75dpvcPs5RP7C4jNYWebzQquH3hY7A=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFfHFGyfFLnfH39ds9xcldOHx5zC/fcdWITNBPuGcyY=;
	b=PABX9pCfxCMyCifY57Vyr7o/Fmm9g8dOuGNcsEDKmHyHYQW+9c3NEYLXI2sWnLFnHULlEt
	zIRe83Fnrf5jHzrib2vV4wQUpZ7OSbNfuuFgn6t5M1QmMgEXMdiQLbv3SLgAbR3oVXMD8s
	V75dpvcPs5RP7C4jNYWebzQquH3hY7A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-DlDFzTqENQa4a16Ac1LvYQ-1; Wed,
 06 Nov 2024 07:36:25 -0500
X-MC-Unique: DlDFzTqENQa4a16Ac1LvYQ-1
X-Mimecast-MFC-AGG-ID: DlDFzTqENQa4a16Ac1LvYQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 011F91956064;
	Wed,  6 Nov 2024 12:36:21 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BCCF619560AA;
	Wed,  6 Nov 2024 12:36:13 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3 01/33] kheaders: Ignore silly-rename files
Date: Wed,  6 Nov 2024 12:35:25 +0000
Message-ID: <20241106123559.724888-2-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Dominique Martinet <asmadeus@codewreck.org>, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Tell tar to ignore silly-rename files (".__afs*" and ".nfs*") when building
the header archive.  These occur when a file that is open is unlinked
locally, but hasn't yet been closed.  Such files are visible to the user
via the getdents() syscall and so programs may want to do things with them.

During the kernel build, such files may be made during the processing of
header files and the cleanup may get deferred by fput() which may result in
tar seeing these files when it reads the directory, but they may have
disappeared by the time it tries to open them, causing tar to fail with an
error.  Further, we don't want to include them in the tarball if they still
exist.

With CONFIG_HEADERS_INSTALL=y, something like the following may be seen:

   find: './kernel/.tmp_cpio_dir/include/dt-bindings/reset/.__afs2080': No such file or directory
   tar: ./include/linux/greybus/.__afs3C95: File removed before we read it

The find warning doesn't seem to cause a problem.

Fix this by telling tar when called from in gen_kheaders.sh to exclude such
files.  This only affects afs and nfs; cifs uses the Windows Hidden
attribute to prevent the file from being seen.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Masahiro Yamada <masahiroy@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-kernel@vger.kernel.org
---
 kernel/gen_kheaders.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 383fd43ac612..7e1340da5aca 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -89,6 +89,7 @@ find $cpio_dir -type f -print0 |
 
 # Create archive and try to normalize metadata for reproducibility.
 tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --exclude=".__afs*" --exclude=".nfs*" \
     --owner=0 --group=0 --sort=name --numeric-owner --mode=u=rw,go=r,a+X \
     -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 

