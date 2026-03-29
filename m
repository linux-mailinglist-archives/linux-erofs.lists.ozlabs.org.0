Return-Path: <linux-erofs+bounces-3076-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIF2FRIIyWk3tgUAu9opvQ
	(envelope-from <linux-erofs+bounces-3076-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 13:08:02 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D016351B93
	for <lists+linux-erofs@lfdr.de>; Sun, 29 Mar 2026 13:08:00 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkBSD2430z2yYs;
	Sun, 29 Mar 2026 22:07:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f8:192:486::2:0"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774782476;
	cv=none; b=ll0ON+VgVOKSvZkI6qpwMygf8o5xSMiT6cKQAwf2hdQx6kFN3L5CcgISkh8SWaEVZWYa+aGCVoOtbgHqaqH94++1sXxGJeX3Dg0Dkyhy/fgIgpTi6pfoNBoPflQqfTbGthxHfCR599dn571toXCuXXbJcLoQxSf6UD+KmPXbd5lahpn1khWDq7Pyde/7MFmSpooE8ie+yHzUZKVqFZG8JDspudZUvdh+t7H/FkiHNY39h0zCni9JDTrkLRmi2ZTbwfyXzYnjLSVMgUwAX/6ag/oD70kHuC+7ugWKL1KdmyX2LoHu4DsOeJg/qwMxnsGzX8pNrfMYDziUZpl1fK8V2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774782476; c=relaxed/relaxed;
	bh=RxhU2zRFQJPwn1alKxvt3d1j41p1m0pswRCOYSeSKwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgGAB4GQemij6sc6OIczFcwQEkY3OdMp2+xIBzzz2antlHOF1xtaI9Zro4/aWn1pZiWmeYLp5SAulgaSkQZ5nzJ4LnA+RCfhs0IlsIAfX0D6uj4fozZIAgGqkOAxw5SftfwHcc9VH83enmpEU2x8UlzC60Pi0rtKXLcGrMbB7zW/tMPe3LSaF5qcSM5GwY22Jut6eSd8ASvClVV9aU7Y6DSAqtF0O2+3Hjl68BuOjzyTpVasUpZldPVS6ITMMuhQbJtHDQ+AeqzWs4IiwsgsJV6/XeAYM186WBeDxb0HqsLMc6s6TWoY8i8Qw1hjNuy/T7oilYIqkhVlgfHH0LDKAQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=PiLEQZm5; dkim-atps=neutral; spf=pass (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org) smtp.mailfrom=samba.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (3072-bit key; secure) header.d=samba.org header.i=@samba.org header.a=rsa-sha256 header.s=42 header.b=PiLEQZm5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=samba.org (client-ip=2a01:4f8:192:486::2:0; helo=hr2.samba.org; envelope-from=metze@samba.org; receiver=lists.ozlabs.org)
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkBSC0RFFz2xlK
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 22:07:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=RxhU2zRFQJPwn1alKxvt3d1j41p1m0pswRCOYSeSKwk=; b=PiLEQZm5mqvScAjS2ran7A93NN
	tT+0hqNaO3AKSp38VFjDOyr4QqHf3f/PF+otaCe3CHPlw3os32ci3djrk1cBqD0QoXt3Cj1l3rWbk
	2VhlGnA/OnYQzduAxvCOfFunZuYi887tOwzpuwaxAD9U9qBTuBgFZr9ZBYQ4RVf2EcjrlTt68tjxI
	VzJjMsBP5bIXQc+7FkCMtUMPXo5BJ4eIfdkXMudiMTr6OOw0Dly9xZUQ2WPBzDhEmlB/xpOMCn81K
	ViLZrp89MjoXaFWcEnmY3wJkRyOAvQKCa3yzwF3BbuaNm2s1thT9Nk+ilOoR6VnbMT1qlPoKnUxgR
	uGk35xQTni/lUJofQir41P6/cB4pTAu3aBDEt3aSmXyUo1tAFqygU5UQpOfuDYGildw2qghrqeKQP
	jbs24HACeelMd0x7/+0rocvMjfOtLuEbguusbVq73SMM/S1GHueZTkRaFsaMkZsBtKr272mpMP1lc
	b9lye8A4/GwbzG9YVkIUg9qx;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1w6nzj-00000004jUw-0RdL;
	Sun, 29 Mar 2026 11:07:51 +0000
Message-ID: <52ad0aa6-d8dd-4ba1-adf2-f79128df9d90@samba.org>
Date: Sun, 29 Mar 2026 13:07:50 +0200
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
To: David Howells <dhowells@redhat.com>,
 Christian Brauner <christian@brauner.io>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>,
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
References: <20260326104544.509518-1-dhowells@redhat.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <20260326104544.509518-1-dhowells@redhat.com>
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
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3076-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,brauner.io,infradead.org,gmail.com,kernel.org];
	FORGED_SENDER(0.00)[metze@samba.org,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_CC(0.00)[manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: 5D016351B93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Am 26.03.26 um 11:45 schrieb David Howells:
> Hi Christian,
> 
> Could you add these patches to the VFS tree for next?

As this conflicts with ksmbd-for-next (and that's
a branch that's typically rebased every few days)
I'm wondering what that best way is to resolve that
problem.

Maybe we should have a fixed non rebased branch for the
smbdirect.ko patches in ksmbd-for-next, so that David
can rebase on that.

Or should Steve put this also into ksmbd-for-next?

Another possible way would be to skip this for now
cifs: Remove support for ITER_KVEC/BVEC/FOLIOQ from smb_extract_iter_to_rdma()
and I rebase my changes on top of Davids patches assuming they
will be stable commits (at least up to
cifs: Support ITER_BVECQ in smb_extract_iter_to_rdma())

Any ideas?

metze

