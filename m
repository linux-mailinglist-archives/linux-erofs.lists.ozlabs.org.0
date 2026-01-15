Return-Path: <linux-erofs+bounces-1927-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F0CD28236
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Jan 2026 20:37:32 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dsYCs3b3rz2yFm;
	Fri, 16 Jan 2026 06:37:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768505849;
	cv=none; b=a4kjeN3g1QuX5ki+winV6ZKm5dOliyNdCK0hJbf2bvj5ROURKUyDN/GPhnZlZ/c7kXC0+99Ag//thiWvbrhLpBv8w1FOVguJZJjBTqEuaQ+mqmI/M0xgKWnOpiQcI0YrndPCY8+zxqUL4By+ygQnh9GWur2yGxa2EqoHMe7UGA/0niNLIyElsWF+xRbTO9ywZ6fQIv8TeRUcD/BwGIDvkOyCSGGUG1uLdRh6m0IvsN3p7EA3Atz1nlLRGCN0UCcfyLmwItJre3tFezi34VbzvWtv3lxPsgZJky2FBpJ0k0bwyRnC3Z90SW4PqrF/flzpvTcMHXDE0IrFw3KDdF/+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768505849; c=relaxed/relaxed;
	bh=EZT+o0VjsIJqvL4Ye1+Mojw1LAugYAMc89Qw5GYzSAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2t9tP7n1tF/1lxFQpdEP3Vtch2tvnvr4vpbLzt+RLWLbpcMaW8aBx7lwsTp+LmBRQ4SmcV6UvdeJNmp1/NimlYSua7dFPdYwGKO+l3gRcdOAfjINOrU6xLPIt8+kJS/gIZxbv5+ZnHrdmDANzqCjUdXB/8FCBH6GCxl/GqyeRRyZGFUcMYrF989cpigBh7LKcPXINF7TGJLltOIiYcqbwUezoJK6jZt55CsqOufveoPbpH7UT3dMHeOelyYQ/ngBckNtv8+lmLxmjGj3yBNUlNci4uhwCFc2ikMam9HWH/6vx3HSFP5Njr/XgOZzR+iATSduYnHk6STIDIFTCPdhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HFbrkaxb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=HFbrkaxb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=cel@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dsYCr5VMRz2xNg
	for <linux-erofs@lists.ozlabs.org>; Fri, 16 Jan 2026 06:37:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B2A14443E;
	Thu, 15 Jan 2026 19:37:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB8DC116D0;
	Thu, 15 Jan 2026 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768505845;
	bh=WJfdSxntdjCGN+SFF94mp89xagtZVsc8ko5YpfyHmzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HFbrkaxb1G2AMG3MzNBQW/L4EalwCCXCDDxxDQ0j51u/B6PgVvK4NDRP+gGsVfnpe
	 VyaIgHktK2ed+mNcElWfMOvW8ETWuYtZ5BFV7xemUUxHpfR8cVtiKroue7/9G/qCGd
	 rt85fYelVNLihiQeGcg1jxPrf/3yQwBY4s+8zZk5LgZv0Ho8j42Klxvmo6vU2q3pOQ
	 ev3GcW+Npw86laMA3/1Ho9Pk9tnCRdwq68XKqMY+ib2uyFDvs9SuOLSNploZHBt1DR
	 d0vpBTEHYbunJ8ienXua5qZh3TfRauncM885fsO/Gz1dFmAlUhHctfiqlwv2dV0p89
	 QAbmFxgjt0yHA==
Message-ID: <4d9967cc-a454-46cf-909b-b8ab2d18358d@kernel.org>
Date: Thu, 15 Jan 2026 14:37:09 -0500
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
Subject: Re: [PATCH 00/29] fs: require filesystems to explicitly opt-in to
 nfsd export support
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>, Theodore Tso <tytso@mit.edu>,
 Andreas Dilger <adilger.kernel@dilger.ca>, Jan Kara <jack@suse.com>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Sandeep Dhavale <dhavale@google.com>, Hongbo Li <lihongbo22@huawei.com>,
 Chunhai Guo <guochunhai@vivo.com>, Carlos Maiolino <cem@kernel.org>,
 Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>,
 Viacheslav Dubeyko <slava@dubeyko.com>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, Luis de Bethencourt <luisbg@kernel.org>,
 Salah Triki <salah.triki@gmail.com>,
 Phillip Lougher <phillip@squashfs.org.uk>, Steve French <sfrench@samba.org>,
 Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Bharath SM
 <bharathsm@microsoft.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg
 <martin@omnibond.com>, Mark Fasheh <mark@fasheh.com>,
 Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 Dave Kleikamp <shaggy@kernel.org>, David Woodhouse <dwmw2@infradead.org>,
 Richard Weinberger <richard@nod.at>, Jan Kara <jack@suse.cz>,
 Andreas Gruenbacher <agruenba@redhat.com>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@infradead.org>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-xfs@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-unionfs@vger.kernel.org,
 devel@lists.orangefs.org, ocfs2-devel@lists.linux.dev,
 ntfs3@lists.linux.dev, linux-nilfs@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-mtd@lists.infradead.org,
 gfs2@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net
References: <20260115-exportfs-nfsd-v1-0-8e80160e3c0c@kernel.org>
 <CAOQ4uxjOJMwv_hRVTn3tJHDLMQHbeaCGsdLupiZYcwm7M2rm3g@mail.gmail.com>
 <d486fdb8-686c-4426-9fac-49b7dbc28765@app.fastmail.com>
 <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
From: Chuck Lever <cel@kernel.org>
Content-Language: en-US
Organization: kernel.org
In-Reply-To: <CAOQ4uxhnoTC6KBmRVx2xhvTXYg1hRkCJWrq2eoBQGHKC3sv3Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 1/15/26 2:14 PM, Amir Goldstein wrote:
> On Thu, Jan 15, 2026 at 7:32 PM Chuck Lever <cel@kernel.org> wrote:
>>
>>
>>
>> On Thu, Jan 15, 2026, at 1:17 PM, Amir Goldstein wrote:
>>> On Thu, Jan 15, 2026 at 6:48 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>>
>>>> In recent years, a number of filesystems that can't present stable
>>>> filehandles have grown struct export_operations. They've mostly done
>>>> this for local use-cases (enabling open_by_handle_at() and the like).
>>>> Unfortunately, having export_operations is generally sufficient to make
>>>> a filesystem be considered exportable via nfsd, but that requires that
>>>> the server present stable filehandles.
>>>
>>> Where does the term "stable file handles" come from? and what does it mean?
>>> Why not "persistent handles", which is described in NFS and SMB specs?
>>>
>>> Not to mention that EXPORT_OP_PERSISTENT_HANDLES was Acked
>>> by both Christoph and Christian:
>>>
>>> https://lore.kernel.org/linux-fsdevel/20260115-rundgang-leihgabe-12018e93c00c@brauner/
>>>
>>> Am I missing anything?
>>
>> PERSISTENT generally implies that the file handle is saved on
>> persistent storage. This is not true of tmpfs.
> 
> That's one way of interpreting "persistent".
> Another way is "continuing to exist or occur over a prolonged period."
> which works well for tmpfs that is mounted for a long time.

I think we can be a lot more precise about the guarantee: The file
handle does not change for the life of the inode it represents. It
has nothing to do with whether the file system is mounted.


> But I am confused, because I went looking for where Jeff said that
> you suggested stable file handles and this is what I found that you wrote:
> 
> "tmpfs filehandles align quite well with the traditional definition
>  of persistent filehandles. tmpfs filehandles live as long as tmpfs files do,
>  and that is all that is required to be considered "persistent".

I changed my mind about the name, and I let Jeff know that privately
when he asked me to look at these patches this morning.


>> The use of "stable" means that the file handle is stable for
>> the life of the file. This /is/ true of tmpfs.
> 
> I can live with STABLE_HANDLES I don't mind as much,
> I understand what it means, but the definition above is invented,
> whereas the term persistent handles is well known and well defined.

Another reason not to adopt the same terminology as NFS is that
someone might come along and implement NFSv4's VOLATILE file
handles in Linux, and then say "OK, /now/ can we export cgroupfs?"
And then Linux will be stuck with overloaded terminology and we'll
still want to say "NO, NFS doesn't support cgroupfs".

Just a random thought.


-- 
Chuck Lever

