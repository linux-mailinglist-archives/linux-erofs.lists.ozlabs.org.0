Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A93279F3B39
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Dec 2024 21:44:21 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YBsPH5PRyz30ML
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Dec 2024 07:44:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734381857;
	cv=none; b=iQ3Cqk4mxiNPO7VpajjCtTrdu+Iwyej/ILM1kiXwKSZef3lan6XvvMmTMEPLsBHTVF5jlLrt7hqzpqtn0J2j30N+8Usu9KFJqJW61YWDuE/RVBjZ7eBmN6aDQ9xT7pawvNLXzV+LtkuDXjfdoZ9FycPrXimyBTSHy47Vqv6xiuBDmVSOjYws/TaOYA2R3Dxd5Hg+G8KsiASlTu2bYtwb3V2wiVqcQ9dADfmMXZ9VWMV9AdcZDVHnuI6f6YtfzBPT7cWeUsM62m63Zvs+SfocL8AA3Uv6sIm7I66xvVP4x1HxqXJzOfcHVwOeAhyopfMPpyBGmUt03xCzXwIyLyOwVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734381857; c=relaxed/relaxed;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8Jt+eECtHFLIMzxgrPko7WvTv230zssfCymgTFHscnmQZVgI9Cv1Srruzi2rMjQrGB5zUFAL778JNrhsw4ZW6fQlWEffAoDBfXKPO3GHWEGfAq18Z1hP1/YHww9Og4ZrW3tlvZfQJjwef06WmIrhK+TW/q9G/r4Tsep2gPLCbU3mZIJh92mOLHta+0xcMDVN8Dgx0ylkEH+PIEHx7bHMAdBtjkls2kPbD5uvak0THs31Dg+9GWyP7NV6P97cNMGZerYGM2uVB59qG+c0HqpaRLA5voGkAamdbOV7rDTs5NJfB1+iTaVGo2zGsI04p2Bu3pwk4tn49kGV9W1oZ/toA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbPY1WpW; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbPY1WpW; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbPY1WpW;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WbPY1WpW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YBsPC493Tz2y8V
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Dec 2024 07:44:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=WbPY1WpWPxoBYjBm/bKf2bnLFa6WkhEgNMxDIDP3aOBEN9jPTz1DnwM/jFyvrxOLviwK2b
	zoGc3obGeFYmeO5bmWE+3BH99atKPudMJJH2R7/P06FnEQZpqjfpfbarVkxd2H/yxpEHZH
	ShuRSnN5ZxRSsk7A1GXXBxfTHDpEGQk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=WbPY1WpWPxoBYjBm/bKf2bnLFa6WkhEgNMxDIDP3aOBEN9jPTz1DnwM/jFyvrxOLviwK2b
	zoGc3obGeFYmeO5bmWE+3BH99atKPudMJJH2R7/P06FnEQZpqjfpfbarVkxd2H/yxpEHZH
	ShuRSnN5ZxRSsk7A1GXXBxfTHDpEGQk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-212-FSMi43-SNXSWMNkiuFpBFg-1; Mon,
 16 Dec 2024 15:44:07 -0500
X-MC-Unique: FSMi43-SNXSWMNkiuFpBFg-1
X-Mimecast-MFC-AGG-ID: FSMi43-SNXSWMNkiuFpBFg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54C011955F3E;
	Mon, 16 Dec 2024 20:44:03 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BE50F19560A2;
	Mon, 16 Dec 2024 20:43:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 20/32] afs: Make afs_init_request() get a key if not given a file
Date: Mon, 16 Dec 2024 20:41:10 +0000
Message-ID: <20241216204124.3752367-21-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
Cc: Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, Shyam Prasad N <sprasad@microsoft.com>, linux-cifs@vger.kernel.org, netdev@vger.kernel.org, Dominique Martinet <asmadeus@codewreck.org>, Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org, v9fs@lists.linux.dev, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org, linux-mm@kvack.org, netfs@lists.linux.dev, Marc Dionne <marc.dionne@auristor.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In a future patch, AFS directory caching will go through netfslib and this
will involve, at times, running on behalf of ->lookup(), which doesn't
provide us with a file from which we can get an authentication key.

If a file isn't provided, make afs_init_request() get a key from the
process's keyrings instead when setting up a read.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f717168da4ab..a9d98d18407c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -372,10 +372,26 @@ static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
+
 	if (file)
 		rreq->netfs_priv = key_get(afs_file_key(file));
 	rreq->rsize = 256 * 1024;
 	rreq->wsize = 256 * 1024 * 1024;
+
+	switch (rreq->origin) {
+	case NETFS_READ_SINGLE:
+		if (!file) {
+			struct key *key = afs_request_key(vnode->volume->cell);
+
+			if (IS_ERR(key))
+				return PTR_ERR(key);
+			rreq->netfs_priv = key;
+		}
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
 

