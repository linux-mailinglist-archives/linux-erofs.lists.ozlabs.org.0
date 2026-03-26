Return-Path: <linux-erofs+bounces-3020-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJ7pKLsOxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3020-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:47:23 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE59333B7C
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:47:22 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL7r3FmWz2ygp;
	Thu, 26 Mar 2026 21:47:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522040;
	cv=none; b=g3mcbpEDyLO5Nn/DyfMeaKX8FFfEkjAfK7AgfZV6dRFim7etAmBIe6U0cL7T8+o1D7+SiJAP7LQzGeZFCYoo/cqDBI5u3UwGekKSaAcfdO8OiEvSpYtbQdm/s4rCveX8wxnsHh796XH6OanTLRdpEA8iBcNfI/LTIyexipt3NGHhR1+F2Y9FAun1sW7+mNq5/YDkHMSElj/slNT8mCUfvIujufc6gOnLK7PAWg1lTp4PCuabOX3w8mhN4d8PLfnfJ8L/VVs9n2tOFUoqkqCTGep6CF3SLuPMqMJOGg/xbe8rRZ/aMGbAjuvKuWJN3DNcuXsH+kKbNI27+Sgs2goQqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522040; c=relaxed/relaxed;
	bh=8pMTqSI3JlWcbbZ5ax9gnuhYVE8KLn3P9vdg2r2cDfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=k4CGyGPFOWclY+vjqSjrg1K20N668wQSJd8+hw3A8lypd9MizXmvNCEHJr2xpzjzJ5r0NMWvgoUXGEAhhxX5eTISikDKZI70RgJV0pz1GaZFs6u1ozCe2V7RGeuMF01XKGPanSEF3zSZZVTU0Nuu5d4A6xTSPSVaXf/8iiXEFBt3XXyw4Y3MrXpDBDnEdDTrkxnniZ1+CDVqDx5yTxhk7tOd5+K4+qRj7qxXSoRUT7Lta7fEcNCYetDXKK7Zaj66IlVOAaQyFvoqlP3CyI44TxdOzLd5g3tG4/lgXEstdu1jtEEa2B2YgMK4Gw0V1uXHTsWlvqxYDUf0/JUMBbJr2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGrwS7co; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGrwS7co; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGrwS7co;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NGrwS7co;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL7q4cWQz2yVB
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:47:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMTqSI3JlWcbbZ5ax9gnuhYVE8KLn3P9vdg2r2cDfs=;
	b=NGrwS7coxl6I9VYfl0m7eeL6gxPmsf2JbgNxApZUxWfeYiYSbsPej91LULON7Q8HIQx01z
	5WJs+er8x20xh/P+VybsU31DWCxqCOfIHSy78h+sfeUjxM+mTMCuSX1iJKkBNt+gvoYCHD
	tsFG721zf/zruVh1QLsnR84nK64mvSw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774522036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8pMTqSI3JlWcbbZ5ax9gnuhYVE8KLn3P9vdg2r2cDfs=;
	b=NGrwS7coxl6I9VYfl0m7eeL6gxPmsf2JbgNxApZUxWfeYiYSbsPej91LULON7Q8HIQx01z
	5WJs+er8x20xh/P+VybsU31DWCxqCOfIHSy78h+sfeUjxM+mTMCuSX1iJKkBNt+gvoYCHD
	tsFG721zf/zruVh1QLsnR84nK64mvSw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-292P2OpvMDm-lsocWZMW3Q-1; Thu,
 26 Mar 2026 06:47:12 -0400
X-MC-Unique: 292P2OpvMDm-lsocWZMW3Q-1
X-Mimecast-MFC-AGG-ID: 292P2OpvMDm-lsocWZMW3Q_1774522029
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5B90819560BB;
	Thu, 26 Mar 2026 10:47:09 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.33.121])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E9D3519560B1;
	Thu, 26 Mar 2026 10:47:01 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Jens Axboe <axboe@kernel.dk>,
	Leon Romanovsky <leon@kernel.org>,
	Steve French <sfrench@samba.org>,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Trond Myklebust <trondmy@kernel.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	NeilBrown <neil@brown.name>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
Date: Thu, 26 Mar 2026 10:45:22 +0000
Message-ID: <20260326104544.509518-8-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
References: <20260326104544.509518-1-dhowells@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: 7qPp_1nSR6fFqoeTxCo3rlL9h09yrNG3xX-PGY4pXwY_1774522029
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3020-lists,linux-erofs=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,brown.name,manguebit.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:dhowells@redhat.com,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:neil@brown.name,m:pc@manguebit.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[manguebit.org:email,linux.dev:email,brown.name:email,auristor.com:email,infradead.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: BBE59333B7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When cachefiles_cull() calls cachefiles_bury_object(), the latter eats the
former's ref on the victim dentry that it obtained from
cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
of the victim in place, resulting in occasional:

  WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefilesd/11831
  cachefiles_cull+0x8c/0xe0 [cachefiles]
  cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
  cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
  vfs_write+0xc3/0x480
  ...

reports.

Actually, it's worse than that: cachefiles_bury_object() eats the ref it was
given - and then may continue to the now-unref'd dentry it if it turns out to
be a directory.  So simply removing the aberrant dput() is not sufficient.

Fix this by making cachefiles_bury_object() retain the ref itself around
end_removing() if it needs to keep it and then drop the ref before returning.

Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing() and end_removing()")
Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: NeilBrown <neil@brown.name>
cc: Paulo Alcantara <pc@manguebit.org>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/cachefiles/namei.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index e5ec90dccc27..20138309733f 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -287,14 +287,14 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	if (!d_is_dir(rep)) {
 		ret = cachefiles_unlink(cache, object, dir, rep, why);
 		end_removing(rep);
-
 		_leave(" = %d", ret);
 		return ret;
 	}
 
 	/* directories have to be moved to the graveyard */
 	_debug("move stale object to graveyard");
-	end_removing(rep);
+	dget(rep);
+	end_removing(rep); /* Drops ref on rep */
 
 try_again:
 	/* first step is to make up a grave dentry in the graveyard */
@@ -304,8 +304,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 	/* do the multiway lock magic */
 	trap = lock_rename(cache->graveyard, dir);
-	if (IS_ERR(trap))
-		return PTR_ERR(trap);
+	if (IS_ERR(trap)) {
+		ret = PTR_ERR(trap);
+		goto out;
+	}
 
 	/* do some checks before getting the grave dentry */
 	if (rep->d_parent != dir || IS_DEADDIR(d_inode(rep))) {
@@ -313,25 +315,27 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		 * lock */
 		unlock_rename(cache->graveyard, dir);
 		_leave(" = 0 [culled?]");
-		return 0;
+		ret = 0;
+		goto out;
 	}
 
+	ret = -EIO;
 	if (!d_can_lookup(cache->graveyard)) {
 		unlock_rename(cache->graveyard, dir);
 		cachefiles_io_error(cache, "Graveyard no longer a directory");
-		return -EIO;
+		goto out;
 	}
 
 	if (trap == rep) {
 		unlock_rename(cache->graveyard, dir);
 		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
+		goto out;
 	}
 
 	if (d_mountpoint(rep)) {
 		unlock_rename(cache->graveyard, dir);
 		cachefiles_io_error(cache, "Mountpoint in cache");
-		return -EIO;
+		goto out;
 	}
 
 	grave = lookup_one(&nop_mnt_idmap, &QSTR(nbuffer), cache->graveyard);
@@ -343,11 +347,12 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 
 		if (PTR_ERR(grave) == -ENOMEM) {
 			_leave(" = -ENOMEM");
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		cachefiles_io_error(cache, "Lookup error %ld", PTR_ERR(grave));
-		return -EIO;
+		goto out;
 	}
 
 	if (d_is_positive(grave)) {
@@ -362,7 +367,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		unlock_rename(cache->graveyard, dir);
 		dput(grave);
 		cachefiles_io_error(cache, "Mountpoint in graveyard");
-		return -EIO;
+		goto out;
 	}
 
 	/* target should not be an ancestor of source */
@@ -370,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 		unlock_rename(cache->graveyard, dir);
 		dput(grave);
 		cachefiles_io_error(cache, "May not make directory loop");
-		return -EIO;
+		goto out;
 	}
 
 	/* attempt the rename */
@@ -404,8 +409,10 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 	__cachefiles_unmark_inode_in_use(object, d_inode(rep));
 	unlock_rename(cache->graveyard, dir);
 	dput(grave);
-	_leave(" = 0");
-	return 0;
+	_leave(" = %d", ret);
+out:
+	dput(rep);
+	return ret;
 }
 
 /*
@@ -812,7 +819,6 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
-	dput(victim);
 	if (ret < 0)
 		goto error;
 


