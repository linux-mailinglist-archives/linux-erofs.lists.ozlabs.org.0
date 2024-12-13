Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1251D9F0DB2
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 14:50:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8rMS6y76z3c6c
	for <lists+linux-erofs@lfdr.de>; Sat, 14 Dec 2024 00:50:44 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734097843;
	cv=none; b=OaJbAkfuOyxruzbMGcZWWjzlqW7aP5A+imw914haMedj5b7mOn0xy2LX6RCUQn+lSJf9ZkgYr3e3ruh0SCS0ZuONCb3hjXNY1GeHjdZ1OW9lZrYyuRzGC1b3Q2BLkPAMSwikcqecom1cid82CZjGJtRm+Zt7vu9Cokmy346k0FZE9vKtywouhcIecZo2YCTEaEF5oux+lP+Pt0NpBU9ePaY78W4Dl0Vq9L0Ign3kuLh60HucIcY5gViWA4HKeYIkAIJYAn4QWoZ5sfcL87EkYr/e6fz00feryEdC5WOMl0XABsn/iInXwavcpXhuoOAT2lbQTogqVXCKG1GjbR0OZg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734097843; c=relaxed/relaxed;
	bh=zFfHFGyfFLnfH39ds9xcldOHx5zC/fcdWITNBPuGcyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYQaBoUhld0c+/Ph71H54Il1ftVfj6vnMCpazPlDCkZmz7vRECdJ7wkkv1Ih5O57oVRPOgRAAgZ8Wzch7mI8uf2S93fzo46lxYlzIZfuhnZ3r5LiTmqw/855+ZzJUkPwPB6mkTMazis8DoHFd/7wtrVWCLt23znmGTxdJND3BzeA/03unxSUydzuVZhPKIis68Q4ZMRIJNgTghPqGNnJCFM7qtFe8K4xtDcmane5bTTi4nI6AT7CxfE4ohEUOKbYolmN2bYasgFMaSrd1xz+b4LVQlaYG86cVEhGPc6sr2S5yFhTK4h5D1yqfbtXw5k2hoG1Go30gt5W9b7dGk40uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAUgyAqG; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAUgyAqG; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAUgyAqG;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dAUgyAqG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8rMQ5VR8z3bTf
	for <linux-erofs@lists.ozlabs.org>; Sat, 14 Dec 2024 00:50:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFfHFGyfFLnfH39ds9xcldOHx5zC/fcdWITNBPuGcyY=;
	b=dAUgyAqGBnSmDkAzLoYLbGJM7jy5+4XHHGZKxzR+HQ6D6SfvsaVP3uFjo3ahzO7bnlhSb1
	CCGstS8kFfl9jjxn6rC0Ej56YtrvcJqxbRAlvW9a30+e6+FCYgV+DQfk104BLGN2A4fSar
	pTb+UPs7N5j3ojFU8K70AHmoUdXG4Hg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFfHFGyfFLnfH39ds9xcldOHx5zC/fcdWITNBPuGcyY=;
	b=dAUgyAqGBnSmDkAzLoYLbGJM7jy5+4XHHGZKxzR+HQ6D6SfvsaVP3uFjo3ahzO7bnlhSb1
	CCGstS8kFfl9jjxn6rC0Ej56YtrvcJqxbRAlvW9a30+e6+FCYgV+DQfk104BLGN2A4fSar
	pTb+UPs7N5j3ojFU8K70AHmoUdXG4Hg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-qo9Op8B1MvuELGCTRl92nA-1; Fri,
 13 Dec 2024 08:50:33 -0500
X-MC-Unique: qo9Op8B1MvuELGCTRl92nA-1
X-Mimecast-MFC-AGG-ID: qo9Op8B1MvuELGCTRl92nA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A073919560A6;
	Fri, 13 Dec 2024 13:50:30 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BB0A9195394B;
	Fri, 13 Dec 2024 13:50:23 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Subject: [PATCH 01/10] kheaders: Ignore silly-rename files
Date: Fri, 13 Dec 2024 13:50:01 +0000
Message-ID: <20241213135013.2964079-2-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Spam-Status: No, score=-0.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
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
Cc: linux-cifs@vger.kernel.org, Max Kellermann <max.kellermann@ionos.com>, Masahiro Yamada <masahiroy@kernel.org>, Marc Dionne <marc.dionne@auristor.com>, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, netfs@lists.linux.dev, Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org, Trond Myklebust <trondmy@kernel.org>
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
 

