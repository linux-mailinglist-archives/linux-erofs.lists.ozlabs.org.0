Return-Path: <linux-erofs+bounces-3119-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHHvF2SBymkW9gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3119-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 15:57:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18C35C705
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 15:57:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkt9p5PNMz2xpt;
	Tue, 31 Mar 2026 00:57:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774879070;
	cv=none; b=BjrBZa3YQ3iRfeFTD2gqhnCv01O3qwhWWLVZbgly6QhonHMjM6pZLQAeL2SJfYE4RSqn2+q2J1Awyuqn+4FmvVw/gQ8C6v2pzbFYcRXl8/DDixVkq8h3VxiVPJcRa2W0Du5BjrCF4YD2C5N3Ek22Y9xYO/mMOM5u+KnoXlneCcAuzOoWyOkH+dWMbwo5R9wTBC0uMQ/lEgKbPG3Bu7jjSmSyh9VlQaGmT+Xcl5+sW3cbd1nqPCVcymbMPmx2mLra7BqThMjgiCv1JNK2MyV1VOwJDPKgY9TBwFnbp73VEsiT7X/74uwXnTrMBTvE129rV5749/9+nlKMmdF+5KsH+w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774879070; c=relaxed/relaxed;
	bh=aHLXtwCMFeKjEs/VsnRh986+QoltAhaGyi5eb+m+M2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYpLY9h9/yrVcp4SqilagjBaFZCnq8y3jJCO1bo766vYPtXh2wTkaoOZF5J+DBJBU+TMDQsxJycnrNrc3ueqrW44bo5yzRTiyejJKRpVa8u7tyXqIbxGSnneEmnTxxpPAMdefcPszx8vKJcW2drviIsWQROMIMlg1RQ2tAwzrzcx8s3oNQM/q3/rAd3vhgpdWgfuiV+Oqo18pRcZ/EwTY3JzHc5qCKHf+Ae7txv3D2LElg4tAyZi2qYohQ0svU1Ore2qI30J/c0Wrtl7PIpvkCB+8I4seyKNMbex02xwVy7dSr5AjYo5EczPBdKYxz/42WUVAqhghg2s5W8cGT6Xcw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=lSYNp7Wf; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org) smtp.mailfrom=samba.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=lSYNp7Wf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samba.org (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkt9m3lb5z2xT6
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 00:57:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=aHLXtwCMFeKjEs/VsnRh986+QoltAhaGyi5eb+m+M2o=; b=lSYNp7WftXgNZI9nAPuFMFcKqY
	HEmA505012e9xqEKFQaNN1zovmIMMfDhNZY37xSKz2H2whDuvOmUZFmRxWz3Yaqnl/BelRXXp44rw
	Y37GF+vBFdN1uNuw5CZTbr66zdDM08ln+E5ImeL4BcoAfP9R9v1BIE9GZHzP9ZWEWNuFwee+HjifT
	Xpye22zs124AMG/L1f2BAIylpljBlz0jNngKSbDfSWKnSx4pR7WEfoAfIANLq+RGWwpoqALSvK5wq
	QwAGdLAO0tdCgSWWQw5JXUdt7q4bCG8mpUq4nc5S1VfADIFpRkXiOCjGf6UJ/FNmqyfheFdUVwZu4
	9mmWLziXMCsHMnERmzv106kqFnT+hqVLPuW/f84tnZfNDxT/oB25+Pw3ASTxShUG260kt9palsKsg
	TN/W2lMJA++aKUig0vH7n6qlghHLahYcjmUvDxhrAIl/0/94Y9U77HhO+CgFinlTv1xR/drRKxmik
	sB9oukHjqX3Ywk7rgEeGLZEC;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1w7D7b-000000055qd-0zuk;
	Mon, 30 Mar 2026 13:57:39 +0000
Message-ID: <9639cd12-5e9d-4eb4-9d9c-f5047ccad7b7@samba.org>
Date: Mon, 30 Mar 2026 15:57:38 +0200
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] netfs: Keep track of folios in a segmented
 bio_vec[] chain
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>,
 Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
 Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>,
 ChenXiaoSong <chenxiaosong@chenxiaosong.com>,
 Marc Dionne <marc.dionne@auristor.com>,
 Eric Van Hensbergen <ericvh@kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>,
 netfs@lists.linux.dev, linux-afs@lists.infradead.org,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
 linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org>
 <20260326104544.509518-1-dhowells@redhat.com>
 <1180465.1774867781@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <1180465.1774867781@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3119-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[brauner.io,infradead.org,gmail.com,kernel.org,manguebit.com,kernel.dk,samba.org,chenxiaosong.com,auristor.com,codewreck.org,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:dkim,samba.org:email,samba.org:mid]
X-Rspamd-Queue-Id: 3A18C35C705
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 30.03.26 um 12:49 schrieb David Howells:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> Another possible way would be to skip this for now
>> cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_rdma()
>> and I rebase my changes on top of Davids patches assuming they
>> will be stable commits (at least up to
>> cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma())
> 
> I could certainly split my removal patch.  I want to remove FOLIOQ support,
> but I can leave KVEC and/or BVEC if they're still needed.

Yes, please keep them, I guess we can removed unused stuff at the end of the
merge window.

Any idea on how to resolve the actual conflict?

Thanks!
metze


