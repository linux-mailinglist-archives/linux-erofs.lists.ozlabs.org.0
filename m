Return-Path: <linux-erofs+bounces-3452-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAwZNScfDGqoWgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3452-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:28:23 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E67557A093
	for <lists+linux-erofs@lfdr.de>; Tue, 19 May 2026 10:28:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gKSJy6rHxz2yFK;
	Tue, 19 May 2026 18:20:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779178802;
	cv=none; b=jAze8UJjhgeyhqaqa4C1cg3Qxf8Qp6U0XAo/FtsFsyb6Ii1GVwaujXHT5JAzmK9j7kAmbs1KRFrIuuD9bmjDtM2EdJ1WsdURIEtYGppRjQHXkHzSgNyTgV+t0CLDktZ0Njz9ws7JHvwmUj+Jn+f+9fsiDbiRpX/pU23Ckgz/LNksTfNar3pC08GFg0abXHHqa0+DdVVRyJjiqF8KkBR1DPhDx6GPoqnLgtQd394+WL7GU030ztnk8LhUPdsF6pMA6Dy0lUNrp/61uPHAVbx4Pkh3aNqeyFyfyRZaC+IFyzwhyA8aMM56Qve/txqr8KC5tPmlsSEdAbr80gcKjF5k7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779178802; c=relaxed/relaxed;
	bh=fr2zJjLeRwLyU1stMgWUrx1BS/dEa/ud23FxfpYN88k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8Y5crz5IZK+pJV/Y+R+ieKxY70uFzqR2oEvtkXD+RNzc51CCojgKsYv5zc6h6WH5qGkhCotLqy0baAwHX+4H2TU7k31U9V76MvVtrZeJUZsDCjIUFDXy5wSHtepQk+SHG+IiQLeVRvch4/AlSgzcXBwF1EJik6BY8/oyWCfHu6Nj/p0vyh4wdlMTPHeBwI9PPQzPZMC49bRxUJ/SiNBhSuFLk1v8Hmbt6ISzGsgkFs/olIsne+1bBnZZgGhMHXQfZMjGAlTVIj1IoTK+/wkzz/nqoUxcZRJdLjXtU+NAjO3n6+dgwsR7u+BlM1KB5HHAQ0p4NpUxnTdzLU5LoUVlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=kuwZ1DAz; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org) smtp.mailfrom=samba.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=kuwZ1DAz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samba.org (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gKSJy0DqYz2xSG
	for <linux-erofs@lists.ozlabs.org>; Tue, 19 May 2026 18:20:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=fr2zJjLeRwLyU1stMgWUrx1BS/dEa/ud23FxfpYN88k=; b=kuwZ1DAzGal4aQoOj1GbVdC865
	rmds6XPQSBxs2++l2qrHmS7opx1hRc6JFcHOLDxv28CyzpVX7YMy3ZXH4C0rEqs8GeTE3/Ob7XFW3
	f0G2XsIq0I/T48R+ySzDLEoAp9NuaMgywT7xLw0H9DGEuUyylhbvn1qiDpYGzT866YvN6siGxqmZZ
	1KQdh5FejimtlL98a4qqAIK4r3XovtJlGPuMeX4YkEkgLn8iaAU9IGZPiySsVZEgBu8o/vjYodAJa
	+cVXeVf7ovNAXUZtBD2CmoCz4ooD02lDXqc5l8qdI8R+m2Co2O4wBhrFimzonL5tvbsjxZubLxoZO
	ARHN9porL18ETE3NAEt/lAhvlzSbpsL2DDGhrgFX5fRo0KaUqitCF2uu1W8Hysm800za8KckXsxXH
	+M8w5u+/UnGGW3oW+lpG26oeVKJOO1kwzlr7TTDNHuGKWshe5cgLbz1PC4mWiInZV9YPF33wutZV8
	iRU6lg5+6+066NUuuXZSKNvS;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wPFgF-0000000A4AG-0bCE;
	Tue, 19 May 2026 08:19:59 +0000
Message-ID: <83ade7bf-9117-400d-b120-ed15401d09ff@samba.org>
Date: Tue, 19 May 2026 10:19:58 +0200
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
Subject: Re: [PATCH v2 14/21] cifs: Remove support for ITER_FOLIOQ from
 smb_extract_iter_to_rdma()
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Jens Axboe <axboe@kernel.dk>,
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
 linux-kernel@vger.kernel.org, Shyam Prasad N <sprasad@microsoft.com>,
 Tom Talpey <tom@talpey.com>
References: <20260518222959.488126-1-dhowells@redhat.com>
 <20260518222959.488126-15-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260518222959.488126-15-dhowells@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [7.30 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.19)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3452-lists,linux-erofs=lfdr.de];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.org,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sprasad@microsoft.com,m:tom@talpey.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	GREYLIST(0.00)[pass,body];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[manguebit.org,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,microsoft.com,talpey.com];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:112.213.38.117:c];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	ARC_ALLOW(0.00)[lists.ozlabs.org:s=201707:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.ozlabs.org:rdns,lists.ozlabs.org:helo,samba.org:email,samba.org:mid,samba.org:dkim,talpey.com:email,manguebit.org:email]
X-Rspamd-Queue-Id: 0E67557A093
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

Am 19.05.26 um 00:29 schrieb David Howells:
> netfslib now only presents an bvecq queue and an associated ITER_BVECQ
> iterator to the filesystem, so it isn't going to see the ITER_FOLIOQ
> iterator.  So remove that code.
> 
> Netfslib also won't supply ITER_BVEC/KVEC iterators, though smbdirect
> might; further in future, it won't supply iterators at all, but rather a
> bvecq slice (that can be used to construct an iterator).
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Steve French <sfrench@samba.org>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: Stefan Metzmacher <metze@samba.org>
> cc: Shyam Prasad N <sprasad@microsoft.com>
> cc: Tom Talpey <tom@talpey.com>
> cc: linux-cifs@vger.kernel.org
> cc: netfs@lists.linux.dev
> cc: linux-fsdevel@vger.kernel.org

Acked-by: Stefan Metzmacher <metze@samba.org>
if you change this in the commit message
cifs: to smbdirect: and smb_extract_iter_to_rdma to
smbdirect_map_sges_from_iter

Thanks!
metze

