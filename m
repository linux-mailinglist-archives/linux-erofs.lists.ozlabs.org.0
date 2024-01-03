Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3328235D3
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jan 2024 20:47:15 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=KqCLgCLv;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=cp+ReJMB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4T50c05mr5z3bsQ
	for <lists+linux-erofs@lfdr.de>; Thu,  4 Jan 2024 06:47:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=KqCLgCLv;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=cp+ReJMB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=codewreck.org (client-ip=91.121.71.147; helo=nautica.notk.org; envelope-from=asmadeus@codewreck.org; receiver=lists.ozlabs.org)
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4T50bt4qV1z3bTN
	for <linux-erofs@lists.ozlabs.org>; Thu,  4 Jan 2024 06:47:06 +1100 (AEDT)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 8030FC023; Wed,  3 Jan 2024 20:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311224; bh=rchUNxdMCqpxIcXW8Gd8rSQ5mpefCht1oHNRmrwB1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqCLgCLvNFzqohtP+Q00yasRxvDCYWdLlzzFXvHOWe9rBinElOfDxYU9K7hZf/nb5
	 yzmsz914DpXIublCq4fenyPl790/cWrEV7Kv4otTyDddP9sHmecTY6qkluQNeTRw7w
	 GKv1xUqnqtUTL42Y2EPdQ80fY9FfEXuGjGRjLZs9Qr5bzV9qoaM3QhgjSJFjppKcmq
	 rXQmZLjbTyRKgOPCBhHEQGlvLYtEwr/yOK1sq/ZJvt8pX0twrYja27PDZZqd+TmdMk
	 WRzeilNoNFYXeYNhQ9F8HKU2gyKS8QlDNkTR7vC3ErTf43wXbMoYLC/aypxu8I24Fw
	 jrRHmZJW8oL+g==
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on nautica.notk.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=UNPARSEABLE_RELAY
	autolearn=unavailable version=3.3.2
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 7F88AC01A;
	Wed,  3 Jan 2024 20:46:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1704311223; bh=rchUNxdMCqpxIcXW8Gd8rSQ5mpefCht1oHNRmrwB1pY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cp+ReJMBn4/XifVWwL9GKWjgkdtOemo/VHptMfuCAey1eLCbRlXG8C98KiVBZWxQz
	 akAQ/UbdziobN/oM86x455uM+VDXCfHi0FGn1LyWCSLZ+O0lcIM1epqEAlYR/oI3bW
	 KDoePmBGHzUHJfEwETut5v+EXyKaJQl3IsJzqKvrTVSxz+zFiA7glGc3YoQxwb3kZG
	 Dk8V40uXy4lDjOa4efxjrsPampxxMLB0G9RZK+y1M1uBtZ2jO2fVIGlj2hdwqGPJ5b
	 cnZIsrl4Zu+sK1EsxMTzzmiNyNw1eykicrjIUmzOzbzIkTLPStHaI5hlFt4HU2Gojv
	 twZElKdDAeHDQ==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 34cd8836;
	Wed, 3 Jan 2024 19:46:53 +0000 (UTC)
Date: Thu, 4 Jan 2024 04:46:38 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 5/5] 9p: Use length of data written to the server in
 preference to error
Message-ID: <ZZW5nlB5v-SDsT_P@codewreck.org>
References: <20240103145935.384404-1-dhowells@redhat.com>
 <20240103145935.384404-6-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240103145935.384404-6-dhowells@redhat.com>
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-mm@kvack.org, Marc Dionne <marc.dionne@auristor.com>, linux-afs@lists.infradead.org, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Steve French <smfrench@gmail.com>, linux-cachefs@redhat.com, Gao Xiang <hsiangkao@linux.alibaba.com>, Ilya Dryomov <idryomov@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, ceph-devel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Christian Brauner <christian@brauner.io>, linux-nfs@vger.kernel.org, netdev@vger.kernel.org, v9fs@lists.linux.dev, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

David Howells wrote on Wed, Jan 03, 2024 at 02:59:29PM +0000:
> In v9fs_upload_to_server(), we pass the error to netfslib to terminate the
> subreq rather than the amount of data written - even if we did actually
> write something.
> 
> Further, we assume that the write is always entirely done if successful -
> but it might have been partially complete - as returned by
> p9_client_write(), but we ignore that.
> 
> Fix this by indicating the amount written by preference and only returning
> the error if we didn't write anything.
> 
> (We might want to return both in future if both are available as this
> might be useful as to whether we retry or not.)
> 
> Suggested-by: Dominique Martinet <asmadeus@codewreck.org>

Thanks,

Acked-by: Dominique Martinet <asmadeus@codewreck.org>

-- 
Dominique Martinet | Asmadeus
