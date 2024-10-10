Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF799984DE
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 13:23:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XPS6x17G8z3bkG
	for <lists+linux-erofs@lfdr.de>; Thu, 10 Oct 2024 22:23:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728559399;
	cv=none; b=de9jDma6czhxfGhiJOTsO/yj+9LObG+mOv/kJAqb3SDhBbLOvWqlrpQi8zbanvfG8C5wPzbGDd8zK08EitaiRzlNen7P+vdB/Eft73fcCt+PrCQ05vxc2SL5fqZ6mvRhUeBT+/jHZFxotuQbQ0vxkz/BZSsEM51lDEghF2lVPnFzsQJiJyr1o7PiB5Ds+VMBXvZyOIJ8J4CK5IOq6Olt2ZpzzASeUL51xC7p2Y66vPGRiDY6UwRNHHYDR/2UxtVBSXFmo5PzKSUyDN5t8cC2IHm2UvStWS3zrgYcjRyQodF5ccSlurANa/KDlzHFwUrUtpN60CjOhU6EHP4P2fmg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728559399; c=relaxed/relaxed;
	bh=0NXJ/YlAi2284RdYmfvHVqovUyQSlsXPT+gI0a/FAik=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=PZgpn/ajzrdNUPImY1D+qj4DsfwPyi9CzFQ7kiaIDGts9wvVNmxFO+R1Dq21vc1MG38W+S8vS3eEJJrd2AApRw2gSe6EbfPUM47Ktapnn55oWttP3b1IdTwNHEvrH1cba8XWWCGBOr4qStmdhhQDrsHXdzMyicsWaPSikbtfMl085S7JemlKTGsg3HYXm3/WfTKvMvDtaX26ZuGuBTFXGITRGFKJY99ynz3pCWD237p46R8GJDVOgGbGvbDuJHSsNHOi/tXGEN3/EjZKjsa2Iogxbkyj8GvARmpS5df9TUFyTdk5fjRATe0p7eFYIa0JOmvdpPVwzewDXilfCsDa8Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQnSp1is; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQnSp1is; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQnSp1is;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SQnSp1is;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XPS6t0GkNz3bfB
	for <linux-erofs@lists.ozlabs.org>; Thu, 10 Oct 2024 22:23:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NXJ/YlAi2284RdYmfvHVqovUyQSlsXPT+gI0a/FAik=;
	b=SQnSp1is7Xedado3PdV5wjqhxiDGoUWAOxhr83g9Ron1NQTR/+Gz0kliCzoLKGwE5Pv6VE
	GdMSmnG8//Ke4TI2J+ChgPO2WAmHExP8hgGi+/booYr/ZDd/FkpwIb14vk4ACngsI/6o1P
	rUqvdREatQpgyvZYQWv8xhDwqh14qNg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728559394;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0NXJ/YlAi2284RdYmfvHVqovUyQSlsXPT+gI0a/FAik=;
	b=SQnSp1is7Xedado3PdV5wjqhxiDGoUWAOxhr83g9Ron1NQTR/+Gz0kliCzoLKGwE5Pv6VE
	GdMSmnG8//Ke4TI2J+ChgPO2WAmHExP8hgGi+/booYr/ZDd/FkpwIb14vk4ACngsI/6o1P
	rUqvdREatQpgyvZYQWv8xhDwqh14qNg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-371-i8qS1cvJP6ysisq-7AS9jg-1; Thu,
 10 Oct 2024 07:23:10 -0400
X-MC-Unique: i8qS1cvJP6ysisq-7AS9jg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9F8C1956096;
	Thu, 10 Oct 2024 11:23:07 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.4])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 984581956086;
	Thu, 10 Oct 2024 11:23:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240821024301.1058918-6-wozizhi@huawei.com>
References: <20240821024301.1058918-6-wozizhi@huawei.com> <20240821024301.1058918-1-wozizhi@huawei.com>
To: Zizhi Wo <wozizhi@huawei.com>
Subject: Re: [PATCH 5/8] cachefiles: Clean up in cachefiles_commit_tmpfile()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <303857.1728559382.1@warthog.procyon.org.uk>
Date: Thu, 10 Oct 2024 12:23:02 +0100
Message-ID: <303858.1728559382@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.0
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
Cc: yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Zizhi Wo <wozizhi@huawei.com> wrote:

> Currently, cachefiles_commit_tmpfile() will only be called if object->flags
> is set to CACHEFILES_OBJECT_USING_TMPFILE. Only cachefiles_create_file()
> and cachefiles_invalidate_cookie() set this flag. Both of these functions
> replace object->file with the new tmpfile, and both are called by
> fscache_cookie_state_machine(), so there are no concurrency issues.
> 
> So the equation "d_backing_inode(dentry) == file_inode(object->file)" in
> cachefiles_commit_tmpfile() will never hold true according to the above
> conditions. This patch removes this part of the redundant code and does not
> involve any other logical changes.
> 
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>

Yeah, that's reasonable - and if it did hold true, all we do is unlink and
relink it.

Acked-by: David Howells <dhowells@redhat.com>

