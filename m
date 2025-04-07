Return-Path: <linux-erofs+bounces-153-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B05A7DC84
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Apr 2025 13:40:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWS2554Y2z2yfv;
	Mon,  7 Apr 2025 21:40:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744026029;
	cv=none; b=CliaAMCng2cH+oELCt0sKXQRKLxPcD6YBB93KCZszrEDXBXAVwvQXsMBUAUxIqcpZDYZX2qvWLJ1BeTUoAAK3UYsUWmZkNlp/HOQSA2HRlPoyZpLmt34YMyCT1ZtSGyrEyHzzdnI0eo7Mqptvi36WINMfmbW34iAk0Ed/vhTwhmVJb73jPUSQF13C9yizUkQrzXLPTHLA7yJtszUsjAYhN8k3lbcbuerYwJANV+60l6oEmicRWLpgFdqMbZSppCmLgBrBq8u88pfU3QIXIm8ggcnII9HwQx9XYxbMggz2TdIiFHUUUt6v+7iJ7Znt8Y/LW46zwGdO6DdAiIraeid4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744026029; c=relaxed/relaxed;
	bh=fHbPi1JEW/89my5vo0fU+kVo3zInspEejiOOz7JNSc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjS4K/ZFqZCMftxTuCp73QRxhd6t3Sdw+JbLtMmOCQqCcOX4CNGr92dyvacxwZsw98bAUnWSwZPSDtaM7O4idEPdc8i2NMvgRbJrCpTLgKrEQJz4xjuauhDT2juHPUiZXCXwmWZqaH5vBHetl4OK6+ZvZeS36uFUtv8rBPWQ4DVtnubmWKScSRPd2j6IlQE1xwbtRjaiX/VQeXuX/D8z4noH9+uqaoX7tsVR7AOn/eofwGWQU9QbrM0x5qoJNZ9WN0lTCT+4b+TT6PIBEaqzeFgRVXaiVimRhqvSy4o5bCrQeNOvpuzEI/4qGqC738nVBAC5jej5cSSbfohEy1OSOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR+7tGOp; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDe36PjC; dkim-atps=neutral; spf=pass (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=kzak@redhat.com; receiver=lists.ozlabs.org) smtp.mailfrom=redhat.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WR+7tGOp;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YDe36PjC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=kzak@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWS240DBpz2ydt
	for <linux-erofs@lists.ozlabs.org>; Mon,  7 Apr 2025 21:40:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744026021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHbPi1JEW/89my5vo0fU+kVo3zInspEejiOOz7JNSc8=;
	b=WR+7tGOpduxLI6EAivUVmYN7C1Up2u/LqEEzlMnEK0P4CYLOyomPo9gHS6y5rR8px8SIdT
	HChxXSMedSfyIEfMXQMn8UzOSo7eEMwMHX0qCCBOo+IKRWFRVvXw9rOuvLm908Lq1qre+X
	H0kz1jOJ04ZcuyMuzmRrARVAxa+a9ck=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744026022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHbPi1JEW/89my5vo0fU+kVo3zInspEejiOOz7JNSc8=;
	b=YDe36PjC+gjMO0NZsZO4c1/30owqoISfQh/DrXK42c8WWN0Ob2PvMNfd3ddpnBQ6YAWrfN
	Z9jqUJWyfLvrZRW2Ngy7b5zZXGBRwYV4+kh8U7UwXNWqf2MEN181ZTRvyXv9J5gKTPbSGm
	bCRPLyM3b2MVmzmO/+LRVvXtrmYP2rw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-tzx01GQ1OQWyu-mSribLXw-1; Mon,
 07 Apr 2025 07:40:18 -0400
X-MC-Unique: tzx01GQ1OQWyu-mSribLXw-1
X-Mimecast-MFC-AGG-ID: tzx01GQ1OQWyu-mSribLXw_1744026016
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BEF91956080;
	Mon,  7 Apr 2025 11:40:16 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.224.198])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 324F31955BC0;
	Mon,  7 Apr 2025 11:40:11 +0000 (UTC)
Date: Mon, 7 Apr 2025 13:40:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Sheng Yong <shengyong2021@gmail.com>
Cc: xiang@kernel.org, hsiangkao@linux.alibaba.com, chao@kernel.org, 
	zbestahu@gmail.com, jefflexu@linux.alibaba.com, dhavale@google.com, 
	linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Sheng Yong <shengyong1@xiaomi.com>, 
	Wang Shuai <wangshuai12@xiaomi.com>
Subject: Re: [PATCH v3 2/2] erofs: add 'offset' mount option for file-backed
 & bdev-based mounts
Message-ID: <7nupludayogog6jylmwnxwel4zlvfxeozzcg5qkf5g5a5fpt7g@3bgvpbqfuxxa>
References: <20250407110551.1538457-1-shengyong1@xiaomi.com>
 <20250407110551.1538457-2-shengyong1@xiaomi.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407110551.1538457-2-shengyong1@xiaomi.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Mon, Apr 07, 2025 at 07:05:51PM +0800, Sheng Yong wrote:
> From: Sheng Yong <shengyong1@xiaomi.com>
> 
> When attempting to use an archive file, such as APEX on android,
> as a file-backed mount source, it fails because EROFS image within
> the archive file does not start at offset 0. As a result, a loop
> device is still needed to attach the image file at an appropriate
> offset first. Similarly, if an EROFS image within a block device
> does not start at offset 0, it cannot be mounted directly either.

Does it work with mount(8)? The mount option offset= has been defined
for decades as userspace-only and is used for loop devices. If I
remember correctly, libmount does not send the option to the kernel at
all. The option also triggers loop device usage by mount(8).

In recent years, we use the "X-" prefix for userspace options.
Unfortunately, loop=, offset=, and sizelimit= are older than any
currently used convention (I see the option in mount code from year
1998).

We can improve it in libmount and add any if-erofs hack there, but my
suggestion is to select a better name for the mount option. For
example, erofsoff=, erostart=, fsoffset=, start=, or similar.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


