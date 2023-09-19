Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D41E7A6C38
	for <lists+linux-erofs@lfdr.de>; Tue, 19 Sep 2023 22:18:16 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.a=rsa-sha256 header.s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C header.b=e7FwFS1N;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RqtJj28LRz3bvd
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 06:18:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.a=rsa-sha256 header.s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C header.b=e7FwFS1N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cs.ucla.edu (client-ip=131.179.128.66; helo=mail.cs.ucla.edu; envelope-from=eggert@cs.ucla.edu; receiver=lists.ozlabs.org)
X-Greylist: delayed 428 seconds by postgrey-1.37 at boromir; Wed, 20 Sep 2023 06:18:05 AEST
Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RqtJY6PFHz2yWD
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 06:18:05 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 7F8E73C00D194;
	Tue, 19 Sep 2023 13:10:50 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
	by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id AN80LNh6AqGG; Tue, 19 Sep 2023 13:10:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id ED2803C00D193;
	Tue, 19 Sep 2023 13:10:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu ED2803C00D193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1695154250;
	bh=rkg9tbxTq6pJj5csNug/eDfUxuv8dlZEs8ZxbrqQ+Bs=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=e7FwFS1NK+ibkS0cG53EL8AQUGclUFwkekbt01t0RrGTfteamSqMsn/mn3buwjYqP
	 Ss5aVs4mQTQ9vMjU5SbCpefiDChbloDYu1HfklTquHXpMe72pT4M6hvyzCQRVAncyf
	 WVOHo5BHpqQpInzk0XI1vkjThUjzXxG9DeoOO1hJGEZWIEF2xR1lMhg3hNLw6eelH3
	 vfkIEJZDbK4SvwqlaNARiGG/pYA5z0FuwJeduSFWqHIxx4VzcDeiRS6F9+AWa/lvRd
	 UJDA/fA+mrJldEyknr58vHs/9vvVt/ptANUNnDyTfqTMtd8U29s7w3jEOKzFb4QdS+
	 p/bV3Yp4QSW6g==
X-Virus-Scanned: amavisd-new at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
	by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gYfshQpOC6VB; Tue, 19 Sep 2023 13:10:49 -0700 (PDT)
Received: from [192.168.254.12] (unknown [47.147.225.57])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id C37643C00D18B;
	Tue, 19 Sep 2023 13:10:48 -0700 (PDT)
Message-ID: <c8315110-4684-9b83-d6c5-751647037623@cs.ucla.edu>
Date: Tue, 19 Sep 2023 13:10:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Jeff Layton <jlayton@kernel.org>, Bruno Haible <bruno@clisp.org>,
 Jan Kara <jack@suse.cz>, Xi Ruoyao <xry111@linuxfromscratch.org>,
 bug-gnulib@gnu.org
References: <20230807-mgctime-v7-0-d1dec143a704@kernel.org>
 <20230919110457.7fnmzo4nqsi43yqq@quack3>
 <1f29102c09c60661758c5376018eac43f774c462.camel@kernel.org>
 <4511209.uG2h0Jr0uP@nimes>
 <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
Subject: Re: [PATCH v7 12/13] ext4: switch to multigrain timestamps
In-Reply-To: <08b5c6fd3b08b87fa564bb562d89381dd4e05b6a.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, linux-unionfs@vger.kernel.org, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, linux-mtd@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, Amir Goldstein <l@gmail.com>, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Hugh Dickins <hughd@google.com>, Benjamin Coddington <bcodding@redhat.com>, Tyler Hicks <code@tyhic
 ks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, linux-cifs@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lis
 ts.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bo b Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2023-09-19 09:31, Jeff Layton wrote:
> The typical case for make
> timestamp comparisons is comparing source files vs. a build target. If
> those are being written nearly simultaneously, then that could be an
> issue, but is that a typical behavior?

I vaguely remember running into problems with 'make' a while ago 
(perhaps with a BSDish system) when filesystem timestamps were 
arbitrarily truncated in some cases but not others. These files would 
look older than they really were, so 'make' would think they were 
up-to-date when they weren't, and 'make' would omit actions that it 
should have done, thus screwing up the build.

File timestamps can be close together with 'make -j' on fast hosts. 
Sometimes a shell script (or 'make' itself) will run 'make', then modify 
a file F, then immediately run 'make' again; the latter 'make' won't 
work if F's timestamp is mistakenly older than targets that depend on it.

Although 'make'-like apps are the biggest canaries in this coal mine, 
the issue also affects 'find -newer' (as Bruno mentioned), 'rsync -u', 
'mv -u', 'tar -u', Emacs file-newer-than-file-p, and surely many other 
places. For example, any app that creates a timestamp file, then backs 
up all files newer than that file, would be at risk.


> I wonder if it would be feasible to just advance the coarse-grained
> current_time whenever we end up updating a ctime with a fine-grained
> timestamp?

Wouldn't this need to be done globally, that is, not just on a per-file 
or per-filesystem basis? If so, I don't see how we'd avoid locking 
performance issues.


PS. Although I'm no expert in the Linux inode code I hope you don't mind 
my asking a question about this part of inode_set_ctime_current:

	/*
	 * If we've recently updated with a fine-grained timestamp,
	 * then the coarse-grained one may still be earlier than the
	 * existing ctime. Just keep the existing value if so.
	 */
	ctime.tv_sec = inode->__i_ctime.tv_sec;
	if (timespec64_compare(&ctime, &now) > 0)
		return ctime;

Suppose root used clock_settime to set the clock backwards. Won't this 
code incorrectly refuse to update the file's timestamp afterwards? That 
is, shouldn't the last line be "goto fine_grained;" rather than "return 
ctime;", with the comment changed from "keep the existing value" to "use 
a fine-grained value"?
