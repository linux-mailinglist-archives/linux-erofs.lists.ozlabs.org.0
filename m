Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BF2962510
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 12:38:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wv18S4LDpz2yn1
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Aug 2024 20:38:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724841478;
	cv=none; b=ODyYwz1JCy7/z1UQKDtg+uopv5Tls/g2nL5lpBlcxrV9RLgwFjQQ6ZD76FFJX3IttkwZLNJlueZuCslR5lpUuMpAJFZUb2y0r/GMlbvWeUj1ZK916WnfC4amFOAfHeMfc3S/33YTu5X8ez5i92mwX9dzJKxSNa5loZmv9OowCWVXYzX2Iy57rktyMB2mVta7CZbz8PO/YFAUpux4MjqQPArnRLoAFS7NlHFEMKNyYD52Y2LVQGcpvSjt6bW6fl4HFSVY3hmGNy8RGXulkScjrrsDPahDhrjfj+hfA5hjajHt+9oiU1s7xgKXsRZAsIRYuNqvt59HcQ3JK1oTNJeAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724841478; c=relaxed/relaxed;
	bh=jzUkFIussh+cyc5LHCiRLDkre+V+EO0118aAT2+MjKQ=;
	h=DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:Received:
	 Received:Organization:From:In-Reply-To:References:To:Cc:Subject:
	 MIME-Version:Content-Type:Content-ID:Content-Transfer-Encoding:
	 Date:Message-ID:X-Scanned-By; b=nn21beJfvMvJPx6GINpKp0loXTjGm+wP3s7URpxXLfJJSbtbUAra+tY/y7BtlJ/+TOz7Rd9k9OdApZ1JRNNjesC5NB2tmTwj+4R5YPoPNdlUWvmR+/s8vm2tteE5NaHzt4fSrCqyX50C0G8XEigtGBAg7ii8NnfBnlKjRU9MGS/NwhfuyBTCNwnmrNMyG0iloHuNNeD5v6ZhNxcYBx2+WmJiwTM1AFJxy6vRCZm2dbEX69M1X4znWurURRHZiebBAQmkPAbwUDWalFEpbQkSAHRqjBGh6hIPyDY7TG7cf5OcjCwxFObzroSrgub9Bg1MAx7UUNCPwClzMM9vOpZDAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZxmvhUIH; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZxmvhUIH; dkim-atps=neutral; spf=pass (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZxmvhUIH;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZxmvhUIH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dhowells@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wv18P3LXYz2yZ7
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Aug 2024 20:37:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724841470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzUkFIussh+cyc5LHCiRLDkre+V+EO0118aAT2+MjKQ=;
	b=ZxmvhUIHcy6sVvF6sRt44C6GmAnweAwg3VZRk5rq/wsGXhW9ijMebUZtcYjCGg4J91BQi8
	5vqt4SIhkw0P8dXQz9cN6KZLU6xirWZceqPTWhQf9AYPAJKHNL0ag+JuA+AlPNWHpnmBi7
	4iPyUIw+p3hCJcLX4anXy4AFvGX4VLw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724841470;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzUkFIussh+cyc5LHCiRLDkre+V+EO0118aAT2+MjKQ=;
	b=ZxmvhUIHcy6sVvF6sRt44C6GmAnweAwg3VZRk5rq/wsGXhW9ijMebUZtcYjCGg4J91BQi8
	5vqt4SIhkw0P8dXQz9cN6KZLU6xirWZceqPTWhQf9AYPAJKHNL0ag+JuA+AlPNWHpnmBi7
	4iPyUIw+p3hCJcLX4anXy4AFvGX4VLw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-xiNa3xA0NW2wayu8oJcNdg-1; Wed,
 28 Aug 2024 06:37:46 -0400
X-MC-Unique: xiNa3xA0NW2wayu8oJcNdg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6E17A1955D4C;
	Wed, 28 Aug 2024 10:37:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.30])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 58CDF1955D56;
	Wed, 28 Aug 2024 10:37:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240826113404.3214786-1-libaokun@huaweicloud.com>
References: <20240826113404.3214786-1-libaokun@huaweicloud.com>
To: libaokun@huaweicloud.com
Subject: Re: [PATCH] netfs: Delete subtree of 'fs/netfs' when netfs module exits
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <952422.1724841455.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Aug 2024 11:37:35 +0100
Message-ID: <952423.1724841455@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Cc: brauner@kernel.org, yangerkun@huawei.com, jlayton@kernel.org, linux-kernel@vger.kernel.org, stable@kernel.org, dhowells@redhat.com, linux-fsdevel@vger.kernel.org, hsiangkao@linux.alibaba.com, netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org, yukuai3@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

libaokun@huaweicloud.com wrote:

> In netfs_init() or fscache_proc_init(), we create dentry under 'fs/netfs=
',
> but in netfs_exit(), we only delete the proc entry of 'fs/netfs' without
> deleting its subtree. This triggers the following WARNING:
> =

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> remove_proc_entry: removing non-empty directory 'fs/netfs', leaking at l=
east 'requests'
> WARNING: CPU: 4 PID: 566 at fs/proc/generic.c:717 remove_proc_entry+0x16=
0/0x1c0
> Modules linked in: netfs(-)
> CPU: 4 UID: 0 PID: 566 Comm: rmmod Not tainted 6.11.0-rc3 #860
> RIP: 0010:remove_proc_entry+0x160/0x1c0
> Call Trace:
>  <TASK>
>  netfs_exit+0x12/0x620 [netfs]
>  __do_sys_delete_module.isra.0+0x14c/0x2e0
>  do_syscall_64+0x4b/0x110
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =

> Therefore use remove_proc_subtree instead() of remove_proc_entry() to
> fix the above problem.
> =

> Fixes: 7eb5b3e3a0a5 ("netfs, fscache: Move /proc/fs/fscache to /proc/fs/=
netfs and put in a symlink")
> Cc: stable@kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Should remove_proc_entry() just remove the entire subtree anyway?

But you can add:

	Acked-by: David Howells <dhowells@redhat.com>

David

